Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWHVTUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWHVTUw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 15:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWHVTUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 15:20:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:50605 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751188AbWHVTUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 15:20:52 -0400
Date: Tue, 22 Aug 2006 12:17:23 -0700
From: Greg KH <gregkh@suse.de>
To: Nix <nix@esperi.org.uk>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Herbert Xu's paged unique skb trimming patch?
Message-ID: <20060822191723.GA2688@suse.de>
References: <20060821184527.GA21938@kroah.com> <87d5asporw.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d5asporw.fsf@hades.wkstn.nix>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 08:13:23PM +0100, Nix wrote:
> On 21 Aug 2006, Greg KH stipulated:
> > Responses should be made by Wed, Auguest 23, 18:00:00 UTC.  Anything
> > received after that time might be too late.
> 
> Dave Miller suggested that Herbert Xu's pskb trimming patch (commit
> e9fa4f7bd291c29a785666e2fa5a9cf3241ee6c3) should go into -stable: did it
> get lost? Without it, network stalls (at least) are quite possible.

It must have gotten lost, I don't see it in our queue, nor in the few
patches I have recevied yesterday.  Care to bounce it to
stable@kernel.org and we can add it to the next release?

thanks,

greg k-h
