Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263032AbUGLU4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbUGLU4v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 16:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUGLU4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 16:56:50 -0400
Received: from mailadmin.wku.edu ([161.6.18.52]:50921 "EHLO mailadmin.wku.edu")
	by vger.kernel.org with ESMTP id S263032AbUGLU4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 16:56:49 -0400
From: "Bikram Assal" <bikram.assal@wku.edu>
Subject: Upgrading from RHL 7.3 to RHEL AS3 and using same old partiton
 on Raid Array
To: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro WebUser Interface v.4.1.8
Date: Mon, 12 Jul 2004 15:56:47 -0500
Message-ID: <web-72140815@mailadmin.wku.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I have 2 questions.

1) I m planning on upgrading from RHL 7.3 to RHEL AS3.
Is it possible to upgrade from RHL 7.3 to RHEL AS3 using the installation CD instead of going for the fresh install ?


2) Currently, we have been using DELL Raid Array.
At boot time, the system mounts the linux partition on the Raid Array.

I wanted to ask whether it is possible to keep the same old partition on Raid Array without losing any data on it and mounting that same partition after RHEL AS3 is installed on the system. Would I just need to add an entry in the /etc/fstab file to mount the linux partition on the Raid Array ???

Currently the partition is created on a logical device /dev/sdb1.

I hope I do not have to create the filesystem on Raid Array device again because of a fresh install because with that I would have to take backup of all the data on some other device and then recreate filesystem on the Raid Array and restore all the files again.

Please let me know what do you think about it.


- Bikram
