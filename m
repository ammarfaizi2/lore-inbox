Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279925AbRKIP2c>; Fri, 9 Nov 2001 10:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279926AbRKIP2V>; Fri, 9 Nov 2001 10:28:21 -0500
Received: from ns1.n-online.net ([195.30.220.100]:45840 "HELO
	mohawk.n-online.net") by vger.kernel.org with SMTP
	id <S279925AbRKIP2O>; Fri, 9 Nov 2001 10:28:14 -0500
Date: Fri, 9 Nov 2001 16:26:07 +0100
From: Thomas Foerster <puckwork@madz.net>
To: linux-kernel@vger.kernel.org
Subject: =?ISO-8859-1?Q?Kernel_Module_/_Patch_with_implements_=22sshfs=22_?=
X-Mailer: Thomas Foerster's registered AK-Mail 3.11 [ger]
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011109152819Z279925-17408+12662@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

i came across the idea to mount a remote filesystem via SSH[1|2].

I've seen a free program for Windows that implements parts of what i'm
thinking of.

Does someone know about a kernel module/patch to implement a "sshfs" ?
(to be used with mount)

What i want to do is to mount my webserver (external ip) from an internal
system (internal ip).

Thanks,
  Thomas

