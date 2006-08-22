Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWHVUlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWHVUlN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 16:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWHVUlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 16:41:13 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16587
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932135AbWHVUlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 16:41:13 -0400
Date: Tue, 22 Aug 2006 13:41:30 -0700 (PDT)
Message-Id: <20060822.134130.51513269.davem@davemloft.net>
To: gregkh@suse.de
Cc: nix@esperi.org.uk, linux-kernel@vger.kernel.org, stable@kernel.org,
       herbert@gondor.apana.org.au
Subject: Re: Herbert Xu's paged unique skb trimming patch?
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060822191723.GA2688@suse.de>
References: <20060821184527.GA21938@kroah.com>
	<87d5asporw.fsf@hades.wkstn.nix>
	<20060822191723.GA2688@suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <gregkh@suse.de>
Date: Tue, 22 Aug 2006 12:17:23 -0700

> On Tue, Aug 22, 2006 at 08:13:23PM +0100, Nix wrote:
> > On 21 Aug 2006, Greg KH stipulated:
> > > Responses should be made by Wed, Auguest 23, 18:00:00 UTC.  Anything
> > > received after that time might be too late.
> > 
> > Dave Miller suggested that Herbert Xu's pskb trimming patch (commit
> > e9fa4f7bd291c29a785666e2fa5a9cf3241ee6c3) should go into -stable: did it
> > get lost? Without it, network stalls (at least) are quite possible.
> 
> It must have gotten lost, I don't see it in our queue, nor in the few
> patches I have recevied yesterday.  Care to bounce it to
> stable@kernel.org and we can add it to the next release?

I've done this, thanks for catching it.
