Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293670AbSCACda>; Thu, 28 Feb 2002 21:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293735AbSCACbS>; Thu, 28 Feb 2002 21:31:18 -0500
Received: from dhcp065-024-127-026.columbus.rr.com ([65.24.127.26]:14478 "EHLO
	mail.rivenstone.net") by vger.kernel.org with ESMTP
	id <S310327AbSCAC0u>; Thu, 28 Feb 2002 21:26:50 -0500
Date: Thu, 28 Feb 2002 21:24:38 -0500
To: Dave Jones <davej@suse.de>, James Simmons <jsimmons@transvirtual.com>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tdfx ported to new fbdev api
Message-ID: <20020301022438.GA4732@rivenstone.net>
In-Reply-To: <20020228214045.E32662@suse.de> <Pine.LNX.4.10.10202281242570.20040-100000@www.transvirtual.com> <20020228221152.K32662@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020228221152.K32662@suse.de>
User-Agent: Mutt/1.3.27i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Now that you mention the penguin, I was reminded of something.
>  Normally with this box, when the fb starts, the top 3rd of the
>  screen has a large white rectangle blitted onto it for reasons
>  I never figured out. Its purely cosmetic (it disappears when scrolling
>  begins), so it wasn't something I really bothered investigating.

   Attila Kesmarki's v0.2.0 patch for tdfxfb fixed this problem for me
when I tested it about a year and a half ago, but I don't think his
updates were ever integrated -- I don't know if there were issues with
the changes or not.

   Anyway, the patches still seem to be up:

http://www.medex.hu/~danthe/tdfx/


-- 
Joseph Fannin
jhf@rivenstone.net

"I think I said something eloquent, like 'Fuck.'" -- Rusty Russell
