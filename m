Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267791AbUH0VNC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267791AbUH0VNC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 17:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267792AbUH0VIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 17:08:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:28361 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267758AbUH0VEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 17:04:48 -0400
Date: Fri, 27 Aug 2004 14:04:17 -0700
From: Greg KH <greg@kroah.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       pmarques@grupopie.com, nemosoft@smcc.demon.nl,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: pwc+pwcx is not illegal
Message-ID: <20040827210417.GA4164@kroah.com>
References: <1093634283.431.6370.camel@cube> <Pine.LNX.4.58.0408271226400.14196@ppc970.osdl.org> <1093640273.431.6484.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093640273.431.6484.camel@cube>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 04:57:53PM -0400, Albert Cahalan wrote:
> On Fri, 2004-08-27 at 15:29, Linus Torvalds wrote:
> > Can we drop this straw-man discussion now?
> > 
> > We don't do binary hooks in the kernel. Full stop.
> 
> Sure. That has nothing to do with whether it would
> be legal or not. It had been implied (by Greg KH)
> that you thought Linux-specific proprietary drivers
> using hooks are illegal.

No, I was trying to state that the hook itself was not allowed.  I'll
let others argue about the legality of the code using such a hook.

Sorry for any confusion about that.

greg k-h
