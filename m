Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWGXGX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWGXGX7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 02:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWGXGX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 02:23:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:57729 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751413AbWGXGX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 02:23:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sxfyRB9jB2EgkORHgwnmJsAtt3WxkdNgL5vlAozmWsn0G0xMGFIxKTw5I6lPL+sXdwNjdFTzLRJyNeYzKeHx2ST+5c3cAe6p07jnS96Kbl9n8Hk7DpVdhCgu9iA1dgE1DcqIiLw+zyaVBYmrviLq+UI7Ie/dheUZA3twk4G4ALI=
Message-ID: <c526a04b0607232323r761c0503mfd90c1b36fd9cd5a@mail.gmail.com>
Date: Mon, 24 Jul 2006 07:23:57 +0100
From: "Adam Henley" <adamazing@gmail.com>
To: "Matt LaPlante" <kernel1@cyberdogtech.com>
Subject: Re: [PATCH 18-rc2] Fix typos in /Documentation : 'F'-'G'
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
In-Reply-To: <20060724013120.dc71ab61.kernel1@cyberdogtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060723124920.76a5d725.kernel1@cyberdogtech.com>
	 <9ec263480607232144g5e283156p86e5f84e8a92380c@mail.google.com>
	 <20060724013120.dc71ab61.kernel1@cyberdogtech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/06, Matt LaPlante <kernel1@cyberdogtech.com> wrote:
> On Sun, 23 Jul 2006 21:44:49 -0700
> "David Rientjes" <rientjes@google.com> wrote:
>
> > On 7/23/06, Matt LaPlante <kernel1@cyberdogtech.com> wrote:
> > > --- a/Documentation/input/ff.txt        2006-07-22 15:09:50.000000000 -0400
> > > +++ b/Documentation/input/ff.txt        2006-07-22 17:07:10.000000000 -0400
> > > @@ -13,7 +13,7 @@
> > >  At the moment, only I-Force devices are supported, and not officially. That
> > >  means I had to find out how the protocol works on my own. Of course, the
> > >  information I managed to grasp is far from being complete, and I can not
> > > -guarranty that this driver will work for you.
> > > +guaranty that this driver will work for you.
> > >  This document only describes the force feedback part of the driver for I-Force
> > >  devices. Please read joystick.txt before reading further this document.
> > >
> >
> > guaranty?
>
> It does look weird, although apparently it is not incorrect:
> http://www.m-w.com/dictionary/guaranty
>
> Generally speaking I've been trying to change as little as possible to achieve correctness...if we want to declare "guarantee" the official spelling for the kernel, theres no reason not to change this one too. :)
>

Now would seem the best time to change it if you were going to.
Though, as you say the "little as possible to achieve correctness"
approach is probably the best .

Alan's previous thoughts on leaving alternative spellings in:
http://lkml.org/lkml/2006/6/29/26
