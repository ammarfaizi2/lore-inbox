Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283080AbRLWBkQ>; Sat, 22 Dec 2001 20:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283056AbRLWBkH>; Sat, 22 Dec 2001 20:40:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27656 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283054AbRLWBj6>; Sat, 22 Dec 2001 20:39:58 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Booting a modular kernel through a multiple streams file
Date: 22 Dec 2001 17:39:26 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a03cke$640$1@cesium.transmeta.com>
In-Reply-To: <Pine.GSO.4.21.0112172059510.6100-100000@weyl.math.psu.edu> <E16Hwks-0001wV-00@schizo.psychosis.cReply-To:
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E16Hwks-0001wV-00@schizo.psychosis.com>
By author:    Dave Cinege <dcinege@psychosis.com>
In newsgroup: linux.dev.kernel
> 
> Deja Vu: *shrug*  Your "all they have to do" is quite heavy.
> (boot loader must implement full cpio/tar[/gzip}
> 

cpio is trivial.  tar is a bit more painful, but not too bad.  gzip is
unacceptable, but should not be required.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
