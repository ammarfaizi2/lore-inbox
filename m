Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280387AbRKXW3w>; Sat, 24 Nov 2001 17:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280402AbRKXW3d>; Sat, 24 Nov 2001 17:29:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49673 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280387AbRKXW3P>; Sat, 24 Nov 2001 17:29:15 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.4.15 - syslinux no longer works (File system problem?)
Date: 24 Nov 2001 14:28:44 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9tp6us$mh7$1@cesium.transmeta.com>
In-Reply-To: <20011124111956.55298.qmail@web10402.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011124111956.55298.qmail@web10402.mail.yahoo.com>
By author:    =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
In newsgroup: linux.dev.kernel
> 
> Yes, syslinux no longer works, every files will have a
> length of zero and the floppy can not boot. However if
> run df it still report that the floppy is occupied
> some bytes exactly equal to the size of the file I
> copied onto floppy. ls shows every file has zero.
> 
> What can I do ?
> 

2.4.15 eats files.  DON'T USE IT.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
