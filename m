Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318919AbSH1PxT>; Wed, 28 Aug 2002 11:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318920AbSH1PxR>; Wed, 28 Aug 2002 11:53:17 -0400
Received: from netlx010.civ.utwente.nl ([130.89.1.92]:36028 "EHLO
	netlx010.civ.utwente.nl") by vger.kernel.org with ESMTP
	id <S318919AbSH1PxO>; Wed, 28 Aug 2002 11:53:14 -0400
Date: Wed, 28 Aug 2002 17:57:32 +0200 (CEST)
From: Gcc k6 testing account <caligula@cam029208.student.utwente.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.32 bootfailure for nfsroot
Message-ID: <Pine.LNX.4.44.0208281746170.21556-100000@cam029208.student.utwente.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ave people

The subject says it all. 
2.5.32 doesn't boot when using nfsroot.
same systems running fine with 2.4.19/2.5.31


SYSTEMS:
   athlon with/without preempt. (flatbak)
   i586 with preempt.           (cam029205)

The relevant configs/dmesg/lspci are on 
cam029208.student.utwente.nl/~caligula. 


SYMPTOMS:
I'm using loadlin to load the kernels. I see the kernel loading,unzipping 
and then...black screen followed by reboot.


Greetz Mu





