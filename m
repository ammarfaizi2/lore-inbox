Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262680AbSJHAeS>; Mon, 7 Oct 2002 20:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262687AbSJHAeR>; Mon, 7 Oct 2002 20:34:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21261 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262680AbSJHAeP>; Mon, 7 Oct 2002 20:34:15 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [bk/patch] Rename driverfs to kfs
Date: 7 Oct 2002 17:39:35 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ant9g7$1mt$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0210071701460.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0210071701460.16276-100000@cherise.pdx.osdl.net>
By author:    Patrick Mochel <mochel@osdl.org>
In newsgroup: linux.dev.kernel
> 
> It's the incredible mutable filesystem. As was talked about at the Kernel
> Summit in Ottawa, and as has been threatened in the past three months,
> here is the patch to rename driverfs to kfs. 
> 

I'd prefer calling it kernelfs or kernfs.  [a-z]fs is a bit too busy a
namespace.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
