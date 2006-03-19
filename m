Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751514AbWCSRCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbWCSRCa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 12:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWCSRCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 12:02:30 -0500
Received: from hera.kernel.org ([140.211.167.34]:43931 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751514AbWCSRC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 12:02:29 -0500
Date: Sun, 19 Mar 2006 17:02:16 GMT
From: Eric Van Hensbergen <ericvh@hera.kernel.org>
Message-Id: <200603191702.k2JH2GDw001607@hera.kernel.org>
To: akpm@osdl.org
Subject: [PATCH] v9fs: update license boilerplate
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       ericvh@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] v9fs: update license boilerplate

Update license boilerplate to specify GPLv2 and remove
the (at your option clause).  This change was agreed to by
all the copyright holders (approvals can be found on
v9fs-developer mailing list).

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---

 fs/9p/9p.c         |    5 ++---
 fs/9p/9p.h         |    5 ++---
 fs/9p/conv.c       |    5 ++---
 fs/9p/conv.h       |    5 ++---
 fs/9p/debug.h      |    5 ++---
 fs/9p/error.c      |    5 ++---
 fs/9p/error.h      |    5 ++---
 fs/9p/fcprint.c    |    5 ++---
 fs/9p/fid.c        |    5 ++---
 fs/9p/fid.h        |    5 ++---
 fs/9p/mux.c        |    5 ++---
 fs/9p/mux.h        |    5 ++---
 fs/9p/trans_fd.c   |    6 ++----
 fs/9p/transport.h  |    5 ++---
 fs/9p/v9fs.c       |    5 ++---
 fs/9p/v9fs.h       |    5 ++---
 fs/9p/v9fs_vfs.h   |    5 ++---
 fs/9p/vfs_addr.c   |    5 ++---
 fs/9p/vfs_dentry.c |    5 ++---
 fs/9p/vfs_dir.c    |    5 ++---
 fs/9p/vfs_file.c   |    5 ++---
 fs/9p/vfs_inode.c  |    5 ++---
 fs/9p/vfs_super.c  |    5 ++---
 23 files changed, 46 insertions(+), 70 deletions(-)

8c9712b48e4f886b34eb8c6104ed879204d2868e
diff --git a/fs/9p/9p.c b/fs/9p/9p.c
index 7d97e9f..1d7ef3a 100644
--- a/fs/9p/9p.c
+++ b/fs/9p/9p.c
@@ -8,9 +8,8 @@
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/fs/9p/9p.h b/fs/9p/9p.h
index 5286b24..82b076a 100644
--- a/fs/9p/9p.h
+++ b/fs/9p/9p.h
@@ -8,9 +8,8 @@
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/fs/9p/conv.c b/fs/9p/conv.c
index 8ca3cc5..758dbcd 100644
--- a/fs/9p/conv.c
+++ b/fs/9p/conv.c
@@ -8,9 +8,8 @@
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/fs/9p/conv.h b/fs/9p/conv.h
index dfb3912..8f5c230 100644
--- a/fs/9p/conv.h
+++ b/fs/9p/conv.h
@@ -8,9 +8,8 @@
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/fs/9p/debug.h b/fs/9p/debug.h
index ff54a7b..4228c0b 100644
--- a/fs/9p/debug.h
+++ b/fs/9p/debug.h
@@ -5,9 +5,8 @@
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/fs/9p/error.c b/fs/9p/error.c
index e4b6f8f..981fe8e 100644
--- a/fs/9p/error.c
+++ b/fs/9p/error.c
@@ -11,9 +11,8 @@
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/fs/9p/error.h b/fs/9p/error.h
index a9794e8..5f3ca52 100644
--- a/fs/9p/error.h
+++ b/fs/9p/error.h
@@ -12,9 +12,8 @@
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/fs/9p/fcprint.c b/fs/9p/fcprint.c
index fc8a984..583e827 100644
--- a/fs/9p/fcprint.c
+++ b/fs/9p/fcprint.c
@@ -6,9 +6,8 @@
  *  Copyright (C) 2005 by Latchesar Ionkov <lucho@ionkov.net>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index c4d13bf..b7608af 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -4,9 +4,8 @@
  *  Copyright (C) 2005, 2006 by Eric Van Hensbergen <ericvh@gmail.com>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/fs/9p/fid.h b/fs/9p/fid.h
index 1fc2dd0..aa974d6 100644
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -4,9 +4,8 @@
  *  Copyright (C) 2005 by Eric Van Hensbergen <ericvh@gmail.com>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/fs/9p/mux.c b/fs/9p/mux.c
index d9a748e..d3785f8 100644
--- a/fs/9p/mux.c
+++ b/fs/9p/mux.c
@@ -7,9 +7,8 @@
  *  Copyright (C) 2004-2005 by Latchesar Ionkov <lucho@ionkov.net>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/fs/9p/mux.h b/fs/9p/mux.h
index 9473b84..6097a4e 100644
--- a/fs/9p/mux.h
+++ b/fs/9p/mux.h
@@ -7,9 +7,8 @@
  *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/fs/9p/trans_fd.c b/fs/9p/trans_fd.c
index 8029844..94e0a7f 100644
--- a/fs/9p/trans_fd.c
+++ b/fs/9p/trans_fd.c
@@ -7,12 +7,10 @@
  *  Copyright (C) 2004-2005 by Latchesar Ionkov <lucho@ionkov.net>
  *  Copyright (C) 2004-2005 by Eric Van Hensbergen <ericvh@gmail.com>
  *  Copyright (C) 1997-2002 by Ron Minnich <rminnich@sarnoff.com>
- *  Copyright (C) 1995, 1996 by Olaf Kirch <okir@monad.swb.de>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/fs/9p/transport.h b/fs/9p/transport.h
index 91fcdb9..b38a4b8 100644
--- a/fs/9p/transport.h
+++ b/fs/9p/transport.h
@@ -7,9 +7,8 @@
  *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 321989a..e49e7d1 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -7,9 +7,8 @@
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 9f63ab8..c134d10 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -5,9 +5,8 @@
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index a759278..43c9f7d 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -5,9 +5,8 @@
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 8100fb5..efda46f 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -7,9 +7,8 @@
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index 12c9cc9..2c42f75 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -7,9 +7,8 @@
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index cd5eeb0..766f11f 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -7,9 +7,8 @@
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 1144d59..59e7441 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -7,9 +7,8 @@
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 588d0d2..d574d73 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -7,9 +7,8 @@
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index d05318f..083ed5a 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -8,9 +8,8 @@
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
  *
  *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
1.1.0
