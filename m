Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbVE0Pve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbVE0Pve (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 11:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbVE0Pve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 11:51:34 -0400
Received: from gate.perex.cz ([82.113.61.162]:22753 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S262487AbVE0PvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 11:51:12 -0400
Date: Fri, 27 May 2005 17:51:07 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: ALSA official git repository
Message-ID: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I created new git tree for the ALSA project at:

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git

	This tree is intended for pushing ALSA changes to Linus
and will follow the kernel development/release cycles once synced for
the first time. It contains all latest patches from ALSA 1.0.9 now.
	I will create another repository (probably alsa-devel.git)
for testing the latest ALSA driver changes (suited for the -mm kernels).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
