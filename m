Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289081AbSAOAku>; Mon, 14 Jan 2002 19:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289325AbSAOAkl>; Mon, 14 Jan 2002 19:40:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9489 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289081AbSAOAk3>; Mon, 14 Jan 2002 19:40:29 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Hardwired drivers are going away?
Date: 14 Jan 2002 16:40:12 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1vtpc$1u0$1@cesium.transmeta.com>
In-Reply-To: <20020114205124.2f05fc56.spyro@armlinux.org> <Pine.LNX.4.40.0201141409580.22904-100000@dlang.diginsite.com> <20020114232247.195bf441.spyro@armlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020114232247.195bf441.spyro@armlinux.org>
By author:    Ian Molton <spyro@armlinux.org>
In newsgroup: linux.dev.kernel
> 
> #2 Not all architectures have a problem with 'far' or 'near' calls, and
> frankly, I'm glad the kernels design isnt being crippled just to serve the
> fundamentally CRAP x86 architecture, for once.
> 

Especially since the x86 *ISN'T* one of the architectures with this
particular problem.  'far' and 'near' as used in this thread don't
refer to the x86 segmentation crud.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
