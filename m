Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWAIVq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWAIVq0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWAIVqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:46:25 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:65512 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1750775AbWAIVqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:46:25 -0500
Date: Mon, 9 Jan 2006 22:46:02 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Dave Jones <davej@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ATI 64-bit fglrx compile patches for 2.6.15-gitX
In-Reply-To: <20060109174055.GB25102@redhat.com>
Message-ID: <Pine.LNX.4.60.0601092241120.2685@kepler.fjfi.cvut.cz>
References: <Pine.LNX.4.60.0601091734300.333@kepler.fjfi.cvut.cz>
 <20060109174055.GB25102@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, Dave Jones wrote:

> On Mon, Jan 09, 2006 at 05:47:01PM +0100, Martin Drab wrote:
>  > 
>  > I know this is a little bit OT here, and if you feel irritated by the 
>  > binary drivers, just ignore this. But in case anyone is interested, here 
>  > are some patches I did that make the the 64-bit fglrx module compile 
>  > (cleanly, at least for me) on 2.6.15-git3 and it seems to work here 
>  > (Mobile Radeon 9600, Athlon64), no guarantee though, you're just going to 
>  > have to try and see yourselfs. ;)
>  > .... 
>  > +#if 0
>  >  module_init(agp_via_init);
>  >  module_exit(agp_via_cleanup);
>  >  
>  >  MODULE_LICENSE("GPL");
>  >  MODULE_AUTHOR("Dave Jones <davej@codemonkey.org.uk>");
>  > +#endif
> 
> If you must assist ATI in continuing to abuse the GPL in code
> that I've written, please do it somewhere that I don't have
> to read about it.

Ah, yes, sorry, I was surprised myself to see this there. It wasn't and 
isn't my intention to help ATI in this, sorry.

I'm going to have to think twice next time before doing something. :)

Martin
