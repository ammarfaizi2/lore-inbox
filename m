Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279228AbRJaVFl>; Wed, 31 Oct 2001 16:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280511AbRJaVFb>; Wed, 31 Oct 2001 16:05:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54022 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279228AbRJaVFU>; Wed, 31 Oct 2001 16:05:20 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.4.14-pre6
Date: 31 Oct 2001 13:05:35 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9rpp2v$7j2$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0110302349550.31996-100000@penguin.transmeta.com> <Pine.LNX.4.33.0110312032110.18881-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33.0110312032110.18881-100000@titan.lahn.de>
By author:    Philipp Matthias Hahn <pmhahn@titan.lahn.de>
In newsgroup: linux.dev.kernel
> 
> > Other changes:
> linux/zlib_fs.h is still missing in you tree and breaks compilation of
> fs/cramfs and other.
> 

I have submitted patches to Linus to make cramfs and zisofs work.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
