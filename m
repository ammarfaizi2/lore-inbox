Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129307AbRB1WX6>; Wed, 28 Feb 2001 17:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129306AbRB1WXj>; Wed, 28 Feb 2001 17:23:39 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:47623 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129305AbRB1WXe>; Wed, 28 Feb 2001 17:23:34 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: binfmt_script and ^M
Date: 28 Feb 2001 14:23:14 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <97jtoi$iv3$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0102271425200.14871-100000@frank.gwc.org.uk> <3A9C36BF.6060608@blue-labs.org> <20010228150711.A12214@pcep-jamie.cern.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010228150711.A12214@pcep-jamie.cern.ch>
By author:    Jamie Lokier <lk@tantalophile.demon.co.uk>
In newsgroup: linux.dev.kernel
>
> David wrote:
> > We wouldn't make the kernel translate m$ word docs into files the kernel 
> > can parse.  It's a userland thing and changing the kernel would change a 
> > legacy that would cause a lot of confusion I would expect.
> 
> Now there's a thought.  binfmt_fileextension, chooses the interpreter
> based on filename :-)
> 

binfmt_misc?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
