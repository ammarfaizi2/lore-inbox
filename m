Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293385AbSBZUhH>; Tue, 26 Feb 2002 15:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293388AbSBZUgq>; Tue, 26 Feb 2002 15:36:46 -0500
Received: from cdserv.meridian-data.com ([206.79.177.152]:2067 "EHLO
	nasexs1.meridian-data.com") by vger.kernel.org with ESMTP
	id <S293380AbSBZUgY>; Tue, 26 Feb 2002 15:36:24 -0500
Message-ID: <2D0AFEFEE711D611923E009027D39F2B153AD4@cdserv.meridian-data.com>
From: "Dennis, Jim" <jdennis@snapserver.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Congrats Marcelo,
Date: Tue, 26 Feb 2002 12:38:55 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marcelo,

 Contratulations on your first "official" kernel release.  It seems to have
gone
 well (except for some complaints on slashdot about -rc4 SPARC patches
missing from
 the patch, but apparently in the full tarball).

 Now I need to know about the status of several unofficial patches:

	XFS
	LVM
	i2c
	Crypto
	FreeS/WAN KLIPS
	LIDS
	rmap


 Shawn was very helpful regarding the XFS+rmap patches --- though I've been
having 
 some trouble with compiling kernels out of that in some configurations
(I'll try to 
 isolate those and submit a coherent bug report, if I can.  Shawn, are you
going to 
 update your set of XFS+rmap patches soon?

 Marcelo, there were some i2c updates included in the lmsensors package,
have they
 submitted those to you for integration into 2.4.19?

(As for the patch-int, that seems to apply with only a couple minor rejects,
to the
 top level Makefile, and Documentation/Configure.help; so that's not a
problem --- 
 beside I want KLIPS, LIDS and patch-int for home, not for work.)

 
