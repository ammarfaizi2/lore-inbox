Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263351AbVCMHUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263351AbVCMHUs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 02:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbVCMHUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 02:20:47 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.138]:17558 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S263351AbVCMHU1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 02:20:27 -0500
Date: Sat, 12 Mar 2005 23:20:16 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <fuse-devel@lists.sourceforge.net>
cc: mc@cs.Stanford.EDU, Miklos Szeredi <miklos@szeredi.hu>
Subject: [CHECKER] Need help on mmap on FUSE (linux user-land file system)
Message-ID: <Pine.GSO.4.44.0503122307480.7031-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does anyone know how to set up mmap on FUSE (linux user-land file system)?
Or is it even possible to have mmap on FUSE?

Our file system checker can potentially check a lot more things if we can
have mmap working on a FUSE file system.  Your help on this are well
appreciated!

-Junfeng

