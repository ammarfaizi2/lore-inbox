Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVALVdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVALVdO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVALV3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:29:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:60615 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261459AbVALV1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:27:22 -0500
Date: Wed, 12 Jan 2005 13:27:16 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050112212716.GA13531@kroah.com>
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112104407.N24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121051360.2310@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501121051360.2310@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 10:57:25AM -0800, Linus Torvalds wrote:
> On Wed, 12 Jan 2005, Chris Wright wrote:
> > Opinions on where to set it up?  vger, osdl, ...?
> 
> I don't personally think it matters. Especially if we make it very clear 
> that it's purely technical, and no vendor politics can enter into it. 

I think vger fits that bill, if for no other reason than to keep the
"osdl is taking over the kernel" rumors at bay :)

That is, if the vger postmasters agree.

thanks,

greg k-h
