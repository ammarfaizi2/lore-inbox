Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265843AbUEUNWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265843AbUEUNWk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 09:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265849AbUEUNWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 09:22:40 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:12556 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S265843AbUEUNWj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 09:22:39 -0400
Date: Fri, 21 May 2004 23:22:11 +1000
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: swsusp: fix swsusp with intel-agp
Message-ID: <20040521132211.GA22482@gondor.apana.org.au>
References: <20040521100734.GA31550@elf.ucw.cz> <E1BR7pl-0000Br-00@gondolin.me.apana.org.au> <20040521111612.GA976@elf.ucw.cz> <20040521111828.GA870@gondor.apana.org.au> <20040521112209.GA951@gondor.apana.org.au> <20040521114125.GA10052@elf.ucw.cz> <40ADFED4.4000601@linuxmail.org> <20040521131916.GF10052@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040521131916.GF10052@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2004 at 03:19:16PM +0200, Pavel Machek wrote:
> 
> > >Suspend2 when/if merged might not need this... This one is not really
> > 
> > I use it too :>
> 
> Aha, okay then. How should the option be called, then?

I like PM_DISK but that's taken already.  Perhaps PM_DISK_COMMON?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
