Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313967AbSDPXpP>; Tue, 16 Apr 2002 19:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313970AbSDPXpM>; Tue, 16 Apr 2002 19:45:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41227 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313967AbSDPXoR>; Tue, 16 Apr 2002 19:44:17 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] i386 arch subdivision into machine types for 2.5.8
Date: 16 Apr 2002 16:43:56 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a9icvs$1a6$1@cesium.transmeta.com>
In-Reply-To: <m1n0w3iaii.fsf@frodo.biederman.org> <200204162327.g3GNRO606562@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200204162327.g3GNRO606562@localhost.localdomain>
By author:    James Bottomley <James.Bottomley@HansenPartnership.com>
In newsgroup: linux.dev.kernel
> 
> Not all boot managers work on voyager: grub and syslinux don't, lilo does (for 
> now) but complains that EBDA is too big.
> 

If syslinux doesn't work, it's a bug.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
