Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWAIRlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWAIRlL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWAIRlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:41:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50922 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964889AbWAIRlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:41:09 -0500
Date: Mon, 9 Jan 2006 12:40:55 -0500
From: Dave Jones <davej@redhat.com>
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ATI 64-bit fglrx compile patches for 2.6.15-gitX
Message-ID: <20060109174055.GB25102@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Martin Drab <drab@kepler.fjfi.cvut.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.60.0601091734300.333@kepler.fjfi.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0601091734300.333@kepler.fjfi.cvut.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 05:47:01PM +0100, Martin Drab wrote:
 > Hi,
 > 
 > I know this is a little bit OT here, and if you feel irritated by the 
 > binary drivers, just ignore this. But in case anyone is interested, here 
 > are some patches I did that make the the 64-bit fglrx module compile 
 > (cleanly, at least for me) on 2.6.15-git3 and it seems to work here 
 > (Mobile Radeon 9600, Athlon64), no guarantee though, you're just going to 
 > have to try and see yourselfs. ;)
 > .... 
 > +#if 0
 >  module_init(agp_via_init);
 >  module_exit(agp_via_cleanup);
 >  
 >  MODULE_LICENSE("GPL");
 >  MODULE_AUTHOR("Dave Jones <davej@codemonkey.org.uk>");
 > +#endif

If you must assist ATI in continuing to abuse the GPL in code
that I've written, please do it somewhere that I don't have
to read about it.

		Dave
