Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273496AbRIQGUy>; Mon, 17 Sep 2001 02:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273498AbRIQGUn>; Mon, 17 Sep 2001 02:20:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273496AbRIQGUd>; Mon, 17 Sep 2001 02:20:33 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] bzImage target for PPC
Date: 16 Sep 2001 23:20:39 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9o44nn$vps$1@cesium.transmeta.com>
In-Reply-To: <E15ipks-0006sS-00@wagner> <20010916212538.F14279@cpe-24-221-152-185.az.sprintbbd.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010916212538.F14279@cpe-24-221-152-185.az.sprintbbd.net>
By author:    Tom Rini <trini@kernel.crashing.org>
In newsgroup: linux.dev.kernel
> 
> What about 'bzlilo' and 'zlilo' ? Those are mentioned too.  Linus, please
> don't apply this.  Hopefully Paul will say that too. :)
> 

They're mentioned, and generally wrong -- the proper way to install a
kernel is "make install", since that one can be customized for the
appropriate system using /sbin/installkernel.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
