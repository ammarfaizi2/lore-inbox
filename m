Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129643AbRCFW5g>; Tue, 6 Mar 2001 17:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129652AbRCFW51>; Tue, 6 Mar 2001 17:57:27 -0500
Received: from hs-gk.cyberbills.com ([216.35.157.254]:31752 "EHLO
	hs-mail.cyberbills.com") by vger.kernel.org with ESMTP
	id <S129643AbRCFW5N>; Tue, 6 Mar 2001 17:57:13 -0500
Date: Tue, 6 Mar 2001 14:56:46 -0800 (PST)
From: "Sergey Kubushin" <ksi@cyberbills.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac13
In-Reply-To: <E14aQA9-0001br-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31ksi3.0103061455260.21503-100000@nomad.cyberbills.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Against vanilla 2.4.2:

=== Cut ===
Patch #0 (patch-2.4.2-ac13.bz2):
+ /usr/bin/bzip2 -d
+ patch -p1 -s
The next patch would create the file drivers/video/sis/Makefile,
which already exists!  Assume -R? [n]
Apply anyway? [n]
1 out of 1 hunk ignored -- saving rejects to file
drivers/video/sis/Makefile.rej
=== Cut ===

---
Sergey Kubushin				Sr. Unix Administrator
CyberBills, Inc.			Phone:	702-567-8857
874 American Pacific Dr,		Fax:	702-567-8808
Henderson, NV, 89014

