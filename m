Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbUE3CN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUE3CN2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 22:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUE3CN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 22:13:28 -0400
Received: from sark.cc.gatech.edu ([130.207.7.23]:3230 "EHLO
	sark.cc.gatech.edu") by vger.kernel.org with ESMTP id S261582AbUE3CN1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 22:13:27 -0400
Date: Sat, 29 May 2004 22:13:26 -0400 (EDT)
From: Younggyun Koh <young@cc.gatech.edu>
To: linux-kernel@vger.kernel.org
Subject: seperate environments for different kernels
Message-ID: <Pine.GSO.4.58.0405292206320.2487@tokyo.cc.gatech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i want to run linux 2.6.6 kernel, which needs upgrade of some system tools
such as module-init-tools and nfs-utils. but other guys using the same
machine with 2.4 kernel don't want me to upgrade them.

is there any way i can make different system tools installed when i boot
with the different kernel images other than mounting root directory to the
different partitions? (i can't create a new partition)

thank you,

			-Younggyun Koh (young@cc.gatech.edu)
