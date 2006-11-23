Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933892AbWKWUXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933892AbWKWUXy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 15:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933897AbWKWUXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 15:23:54 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:34646 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S933892AbWKWUXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 15:23:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uya2Sv0zXuXeyJktMyvst9KRBHuWXX3rIJiwZf4+WM55ZcGRMb4x+PZvQJzd7m5yesVn1JprotG7pa0fzyqzpbIZWPQZjoPdtaCpOBuujS4xlyCoNZ7XpFHE34y70EasThmChZk5G9+jWPxiFI5Msw8ix1BLYK6+ReCTN0q04kM=
Message-ID: <40f323d00611231223o1c3c82c7o78e4bf320fc3d881@mail.gmail.com>
Date: Thu, 23 Nov 2006 21:23:51 +0100
From: "Benoit Boissinot" <bboissin@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.19-rc6-mm1
Cc: "Mariusz Kozlowski" <m.kozlowski@tuxland.pl>, linux-kernel@vger.kernel.org
In-Reply-To: <20061123103607.af7ae8b0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061123021703.8550e37e.akpm@osdl.org>
	 <200611231223.48703.m.kozlowski@tuxland.pl>
	 <20061123103607.af7ae8b0.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/06, Andrew Morton <akpm@osdl.org> wrote:
> On Thu, 23 Nov 2006 12:23:48 +0100
> Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:
> >
> > Hello,
> >
> >       Hmmm ... didn't apply cleanly.
> >
> > patching file kernel/tsacct.c
> > Hunk #1 FAILED at 97.
> > 1 out of 1 hunk FAILED -- saving rejects to file kernel/tsacct.c.rej
>
> I think your local tree is not clean.
>

I get it with a clean tree with:
patch 2.5.9
Copyright (C) 1988 Larry Wall
Copyright (C) 2003 Free Software Foundation, Inc.


regards,

Benoit
