Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291889AbSBHWeJ>; Fri, 8 Feb 2002 17:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291893AbSBHWeC>; Fri, 8 Feb 2002 17:34:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29963 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291889AbSBHWdw>; Fri, 8 Feb 2002 17:33:52 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: What "module license" applies to public domain code?
Date: 8 Feb 2002 14:33:26 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a41jnm$67b$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.30.0202081632041.16834-100000@ran.antd.nist.gov> <m16ZJNl-000OVeC@amadeus.home.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m16ZJNl-000OVeC@amadeus.home.nl>
By author:    arjan@fenrus.demon.nl
In newsgroup: linux.dev.kernel
>
> In article <Pine.LNX.4.30.0202081632041.16834-100000@ran.antd.nist.gov> you wrote:
> 
> > Of course, anyone else would be free to take the code and apply any
> > license whatsoever to it, but my concern is simply what MODULE_LICENSE()
> > line I can legitimately include, if any.
> 
> how about
> 
> MODULE_LICENSE("Dual GPL/Public Domain");
> 
> this would need adding to the proper headers though
> 

The thing is ... public domain isn't a license, it's disavowing
copyright.  Part of what that means is that someone can take the work
and publish it under their own copyright.

For liability reasons, something that get published in the kernel
probably would have to be recopyrighted by someone else and GPL'd.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
