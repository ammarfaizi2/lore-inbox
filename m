Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbTLMCGp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 21:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbTLMCGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 21:06:45 -0500
Received: from cabm.rutgers.edu ([192.76.178.143]:64017 "EHLO
	lemur.cabm.rutgers.edu") by vger.kernel.org with ESMTP
	id S262848AbTLMCGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 21:06:44 -0500
Date: Fri, 12 Dec 2003 21:06:43 -0500 (EST)
From: Ananda Bhattacharya <anandab@cabm.rutgers.edu>
cc: linux-kernel@vger.kernel.org
Subject: Linux Kernel 2.6.0-test11 VFS problem
In-Reply-To: <brdq5f$9sd$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.44.0312122059410.4174-100000@puma.cabm.rutgers.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi, I am trying to get kernel 2.6.0-test11 on my 
laptop. this is really stupid, I got all the "latest" 
utilities etc... etc... etc... 

But when I boot i get this error


###################################
VFS Cannot open root device "hda5" 
Please append a correct "root=" boot option 
Kernel Panic: VFS: Unable to mount root filesystem on hda5 
###################################



here is my grub.conf file

*******************************
title 2.6-test-11
        root (hd0,1)
        kernel /vmlinuz-2.6-test-11 ro root=305
********************************


What am I doing wrong today ??


I know this is something really simple somwhere, but I am 
giving this up and hitting up and hitting a Pilsner 
Urquell.....

 -- 
Recruiter: "How do you write a perl script?"
Canidate : "You type it."
	-Actual phone interview, Circa Nov 2003


