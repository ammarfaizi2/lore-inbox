Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262365AbTCMOLH>; Thu, 13 Mar 2003 09:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262367AbTCMOLG>; Thu, 13 Mar 2003 09:11:06 -0500
Received: from davisson.uni2.net ([130.227.52.105]:42888 "EHLO
	davisson.uni2.net") by vger.kernel.org with ESMTP
	id <S262364AbTCMOKz>; Thu, 13 Mar 2003 09:10:55 -0500
To: lkml <linux-kernel@vger.kernel.org>
Subject: Initialisation code for ELAN-SC400 graphics driver.
From: Jarl Friis <jarl@pallas.dk>
Organization: Software Developer
Date: 13 Mar 2003 15:23:09 +0100
Message-ID: <m0r89b9whe.fsf@linux.pallas.dk>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I try to setup a system using AMD ELAN-SC400.

The kernel is up and runnig fine. But I would like to use the
integrated graphics controller of the Elan SC400. I can set this up in
flat-mapped (linear mapped) framebuffer mode with 4 BPP, and I guess this is
compatible with VESA-fb (not sure). I would like to know how (and
where in the source) to initialise the screen_info code to trigger the
vesafb driver.

Can someone give a clue? or have someone already done this? will they
reveal the code for it?

in what source code file is screen_info initialised on a standard
PC-system?

Jarl

