Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311431AbSCSQk1>; Tue, 19 Mar 2002 11:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311435AbSCSQkR>; Tue, 19 Mar 2002 11:40:17 -0500
Received: from Expansa.sns.it ([192.167.206.189]:39945 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S311431AbSCSQj6>;
	Tue, 19 Mar 2002 11:39:58 -0500
Date: Tue, 19 Mar 2002 17:40:07 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: linux-kernel@vger.kernel.org
Subject: oops at boot with 2.5.7 and i810
Message-ID: <Pine.LNX.4.44.0203191716170.24700-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

also with 2.5.7, as with 2.5.6, I have problems at boot.
I get the usual oops while initialising IDE.

my ide controller is:

00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80
[Master])
        Subsystem: Intel Corporation 82801AA IDE
        Flags: bus master, medium devsel, latency 0
        I/O ports at 2460 [size=16]

unfortunatelly, I do not have even the time to write down oops message,
but eip is c0135068, but then I do not find a similar entry in system.map

any hint

my rootfs in reiserFS, but i do not even reach the mount ...


