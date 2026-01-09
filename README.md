# Unitree G1 Description (URDF & MJCF)

## Overview

This package includes a universal humanoid robot description (URDF & MJCF) for the [Unitree G1](https://www.unitree.com/g1), developed by [Unitree Robotics](https://www.unitree.com/).

The package provides two model variants:
- `urdf/g1_23dof.urdf` - G1 with 23 degrees of freedom (fixed waist)
- `urdf/g1_29dof.urdf` - G1 with 29 degrees of freedom (adding waist and wrist mobility)

Both models support simulation environments including MuJoCo and Gazebo.

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
```

### RViz

```bash
# Default (23-DOF)
ros2 launch g1_description display.launch

# Select specific model
ros2 launch g1_description display.launch model:=23dof
ros2 launch g1_description display.launch model:=29dof
```

### Gazebo

```bash
# Default (23-DOF)
ros2 launch g1_description gazebo.launch

# Select specific model
ros2 launch g1_description gazebo.launch model:=23dof
ros2 launch g1_description gazebo.launch model:=29dof
```
