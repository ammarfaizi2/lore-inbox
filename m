Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261546AbTCGNAC>; Fri, 7 Mar 2003 08:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbTCGNAC>; Fri, 7 Mar 2003 08:00:02 -0500
Received: from ip68-13-105-80.om.om.cox.net ([68.13.105.80]:3712 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261546AbTCGNAB>; Fri, 7 Mar 2003 08:00:01 -0500
Date: Fri, 7 Mar 2003 07:10:38 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.64-bk bootup video oddities
Message-ID: <Pine.LNX.4.44.0303070657470.870-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This morning I went through my normal routine of doing a bk pull and 
testing the resulting compile.  This time I got an interesting result on 
bootup that I do not see any reference to on the list.  After going 
through BIOS POST, the screen went blank.  I then see Tux, but no bootup 
messages at all.  Tux then disappears and, a short time later, the normal 
login prompt appears.  After that, there are no further anomalies.  

My system is Redhat 8.0 based, the video is an ATI Rage Pro card. During 
the compile I did a make oldconfig, and there is no difference in the 
config files.

Did I miss a discussion of something which might cause this?  

