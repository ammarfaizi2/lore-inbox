Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751775AbWFCSkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbWFCSkn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 14:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbWFCSkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 14:40:43 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:29065 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751775AbWFCSkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 14:40:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NmvCLOtbnEbFjDGFHB30nSxwE1baneN8vYUMGWLL4M/O/bOTD2fySG64SG/RYmLq6EWCi4ULP9vD8mzaKsNtNlgxWv3ph9LfVTms7PChHXU3h1JaOeUUaVPlu7sui6Yog576qnKfmZxDqp0vsLfCGanIYETNne6I6cHVZga8nJw=
Message-ID: <f383264b0606031140l2051a2d7p6a9b2890a6063aef@mail.gmail.com>
Date: Sat, 3 Jun 2006 11:40:41 -0700
From: "Matt Reimer" <mattjreimer@gmail.com>
To: "Pierre Ossman" <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
Subject: Re: 2GB MMC/SD cards
In-Reply-To: <20060603141548.GA31182@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <447AFE7A.3070401@drzeus.cx>
	 <20060603141548.GA31182@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Mon, May 29, 2006 at 04:00:26PM +0200, Pierre Ossman wrote:
> > People have been reporting that their Palms, cameras and USB readers
> > will not accept anything else.
>
> I am not aware of any bug reports in this area, so I can't comment.  In
> fact, I see very few reports of MMC problems at all, so I just assume
> that it merely works.  Unless folk report bugs to me...
>
> I don't know what to do about this since I don't have any cards and
> I've not seen any bug reports to investigate what's going on.  So I'm
> just going to say "the code as it stands is correct as to my best
> knowledge, please provide details of it's failings."

I suspect that a lot of these readers are broken, assuming 512 byte blocks.

Matt
