Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262994AbTDFOoL (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 10:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbTDFOoL (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 10:44:11 -0400
Received: from franka.aracnet.com ([216.99.193.44]:55270 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262994AbTDFOoK (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 10:44:10 -0400
Date: Sun, 06 Apr 2003 07:55:41 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 543] New: system halt after startx 
Message-ID: <75730000.1049640941@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	
http://bugme.osdl.org/show_bug.cgi?id=543

           Summary: system halt after startx
    Kernel Version: 2.5.66
            Status: NEW
          Severity: blocking
             Owner: bugme-janitors@lists.osdl.org
         Submitter: llasaa@sohu.com


Distribution:system halt if I start again
Hardware Environment:PIII 800,VIA apollo pro 266,radeon7500
Software Environment:RedHat 8.0,glibc2.3.2,xfree86-4.3.0,gnome-2.2
Problem Description:when I exit from Gnome,startx again. system halt when I see
the Mesh screen. ctrl-alt-Fn doesn't work.I have to press power button to reboot.
(On kernel2.4.20 which I compiled there's not such a problem. And running xinit
the problem won't happen.I have reinstall Xfree86 and compiling kernel-2.5.66
for several times but it stay the same)

Steps to reproduce:1.login and startx.
2.exit from gnome and startx again.
3.system halt.

