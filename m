Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267540AbTCESs0>; Wed, 5 Mar 2003 13:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267547AbTCESs0>; Wed, 5 Mar 2003 13:48:26 -0500
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:38894 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S267540AbTCESsZ>; Wed, 5 Mar 2003 13:48:25 -0500
Date: Wed, 5 Mar 2003 18:58:55 +0000 (GMT)
From: Anton Altaparmakov <aia21@cantab.net>
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
       clausen@gnu.org
Subject: Re: [Linux-NTFS-Dev] [PATCH] reduce ntfs function stack usage (take 2)
In-Reply-To: <3E616196.9A47D80@verizon.net>
Message-ID: <Pine.SOL.3.96.1030305185802.17585A-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Mar 2003, Randy.Dunlap wrote:
> This patch to 2.5.63 reduces stack usage in the NTFS
> generate_default_upcase() function from 0x3d4 bytes to noise.
> 
> Please apply.

Applied to my BK tree. Thanks. Will push it towards Linus soon...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

