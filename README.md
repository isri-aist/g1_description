# Unitree G1 Description (URDF & MJCF)

## Overview

This package includes a universal humanoid robot description (URDF & MJCF) for the [Unitree G1](https://www.unitree.com/g1), developed by [Unitree Robotics](https://www.unitree.com/).

The URDF files come from [unitree_ros](https://github.com/unitreerobotics/unitree_ros/tree/master/robots/g1_description) (mesh paths changed to `package://g1_description/meshes/`). The right model depends on the hardware revision of the robot, given by its `mode_machine` (Unitree app: **Device → Data → Robot → Machine Type**, also printed by `MCControlG1` at startup):

| URDF (`urdf/`) | `mode_machine` | hip {pitch, roll} gear ratio | wrist motor | waist roll/pitch | actuated dof |
|---|:---:|---|---|---|:---:|
| `g1_23dof_rev_1_0` | 4 | {14.3, 22.5} | — | — | 23 |
| `g1_29dof_rev_1_0` | 5 | {14.3, 22.5} | 4010 | free | 29 |
| `g1_29dof_lock_waist_rev_1_0` | 6 | {14.3, 22.5} | 4010 | locked (fixed) | 27 |
| `g1_23dof_mode_10` | 10 | {22.5, 22.5} | — | — | 23 |
| `g1_29dof_mode_11` | 11 | {22.5, 22.5} | 4010 | free | 29 |
| `g1_29dof_mode_12` | 12 | {22.5, 22.5} | 4010 | locked (fixed) | 27 |
| `g1_29dof_mode_13` | 13 | {14.3, 22.5} | 5010 | free | 29 |
| `g1_29dof_mode_14` | 14 | {14.3, 22.5} | 5010 | locked (fixed) | 27 |
| `g1_29dof_mode_15` | 15 | {22.5, 22.5} | 5010 | free | 29 |
| `g1_29dof_mode_16` | 16 | {22.5, 22.5} | 5010 | locked (fixed) | 27 |
| `g1_29dof_mode_18` | 18 | {22.5, 22.5} | 5010 | free | 29 |
| `g1_23dof` (deprecated) | 1 | {14.3, 14.5} | — | — | 23 |
| `g1_29dof` (deprecated) | 2 | {14.3, 14.5} | 4010 | free | 29 |

Every 29dof model also exists as `<model>_no_hands` (e.g. `g1_29dof_mode_15_no_hands`): the rubber hands are replaced by tool connectors with a `left_tool_attach` / `right_tool_attach` frame (used to connect other hands, e.g. Revo2).

Compared to the deprecated models, the current ones have a lighter torso (6.78 kg instead of 8.56 kg), shoulders and torso IMU 1 cm higher, a different waist assembly (29dof), different hip motor limits and, for 5010 wrists, heavier wrists with a longer wrist yaw link.

All models support simulation environments including MuJoCo and Gazebo.

## Robot Structure

G1 humanoid has either 23 or 29 joints depending on the variant. The base 23-DOF configuration includes:

```text
root [⚓] => /pelvis/
    left_hip_pitch_joint [⚙+Y] => /left_hip_pitch_link/
        left_hip_roll_joint [⚙+X] => /left_hip_roll_link/
            left_hip_yaw_joint [⚙+Z] => /left_hip_yaw_link/
                left_knee_joint [⚙+Y] => /left_knee_link/
                    left_ankle_pitch_joint [⚙+Y] => /left_ankle_pitch_link/
                        left_ankle_roll_joint [⚙+X] => /left_ankle_roll_link/
    right_hip_pitch_joint [⚙+Y] => /right_hip_pitch_link/
        right_hip_roll_joint [⚙+X] => /right_hip_roll_link/
            right_hip_yaw_joint [⚙+Z] => /right_hip_yaw_link/
                right_knee_joint [⚙+Y] => /right_knee_link/
                    right_ankle_pitch_joint [⚙+Y] => /right_ankle_pitch_link/
                        right_ankle_roll_joint [⚙+X] => /right_ankle_roll_link/
    waist_yaw_joint [⚙+Z] => /torso_link/
        left_shoulder_pitch_joint [⚙+Y] => /left_shoulder_pitch_link/
            left_shoulder_roll_joint [⚙+X] => /left_shoulder_roll_link/
                left_shoulder_yaw_joint [⚙+Z] => /left_shoulder_yaw_link/
                    left_elbow_joint [⚙+Y] => /left_elbow_link/
                        left_wrist_roll_joint [⚙+X] => /left_wrist_roll_link/
        right_shoulder_pitch_joint [⚙+Y] => /right_shoulder_pitch_link/
            right_shoulder_roll_joint [⚙+X] => /right_shoulder_roll_link/
                right_shoulder_yaw_joint [⚙+Z] => /right_shoulder_yaw_link/
                    right_elbow_joint [⚙+Y] => /right_elbow_link/
                        right_wrist_roll_joint [⚙+X] => /right_wrist_roll_link/
```

**29-DOF variant additions:**
- `waist_roll_joint` and `waist_pitch_joint`
- Left wrist: `left_wrist_pitch_joint`, `left_wrist_yaw_joint`
- Right wrist: `right_wrist_pitch_joint`, `right_wrist_yaw_joint`

## Usages

### [MuJoCo](https://github.com/google-deepmind/mujoco) (recommend)

```bash
pip install mujoco

# Select specific model
python -m mujoco.viewer --mjcf=mjcf/scene_29dof.xml
python -m mujoco.viewer --mjcf=mjcf/scene_23dof.xml
python -m mujoco.viewer --mjcf=mjcf/scene_29dof_no_hands.xml
```

Note: the MJCF files in `mjcf/` are only provided for the deprecated models. The MuJoCo models of all the variants used with mc_rtc are in [g1_mj_description](https://github.com/bastien-muraccioli/g1_mj_description).

### RViz

```bash
# Default (23-DOF)
ros2 launch g1_description display.launch

# Select specific model
ros2 launch g1_description display.launch model:=23dof
ros2 launch g1_description display.launch model:=29dof
ros2 launch g1_description display.launch model:=29dof_no_hands
```

### Gazebo

```bash
# Default (23-DOF)
ros2 launch g1_description gazebo.launch

# Select specific model
ros2 launch g1_description gazebo.launch model:=23dof
ros2 launch g1_description gazebo.launch model:=29dof
ros2 launch g1_description gazebo.launch model:=29dof_no_hands
```
