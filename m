Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVAMBwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVAMBwv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 20:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVAMBwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 20:52:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:4286 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261452AbVALVBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:01:55 -0500
Date: Wed, 12 Jan 2005 12:59:54 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050112205954.GB12319@kroah.com>
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112205350.GM24518@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 03:53:50PM -0500, Dave Jones wrote:
> 
> If you turned the current model upsidedown and vendor-sec learned
> about issues from security@kernel.org a few days before it'd at
> least give us *some* time, as opposed to just springing stuff
> on us without warning.

I think having security@ notify vendor-sec when it finds a real problem
would be a good idea, as a lot of stuff is just sifting through finding
the root cause and fix.  And if security@ still has it's "5 day
countdown" type thing, that still gives you (and me) at least a few days
to run around like mad to update things, which is better than nothing :)

thanks,

greg k-h
