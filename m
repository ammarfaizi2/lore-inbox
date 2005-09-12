Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbVILVEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVILVEt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 17:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVILVEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 17:04:49 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:17728 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932243AbVILVEs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 17:04:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=alsIQez8LTxf3VeYjD/CkpbWwv0iyJDubVfxurIVN2XufpUABK3uDaXfGWtdH93Gqh1OPOGVdhmI7BnOh2kvZcVlVclQoVckWgLWhJaWkZXifA0fmGdH2+rRTpzlyIfgxDIby6bS6nds7MXn0XB4KcWmFbanjyVsAzd5kuFi7CU=
Message-ID: <4d8e3fd3050912140439c14518@mail.gmail.com>
Date: Mon, 12 Sep 2005 23:04:47 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: paolo.ciarrocchi@gmail.com
To: nish.aravamudan@gmail.com
Subject: Re: 2.6.13-mm3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <29495f1d05091213134d917bd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050912024350.60e89eb1.akpm@osdl.org>
	 <4d8e3fd305091208191fbbe804@mail.gmail.com>
	 <29495f1d05091213134d917bd7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/05, Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
> On 9/12/05, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> > On 9/12/05, Andrew Morton <akpm@osdl.org> wrote:
[...]
> > >
> > > - There are several performance tuning patches here which need careful
> > >  attention and testing.  (Does anyone do performance testing any more?)
> >
> > How about the tool announced months ago by Martin J. Bligh ?
> >
> > http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html
> 
> Preferred location is: test.kernel.org (much shorter too!)

I wasn't aware of that, thank you! Now I won't forget anymore that URL ;-)
 
> Also, the problem for -mm3 is that -mm2 did not build on most
> machines. -mm1 did on 4/6. Probably some determination could be made
> from those.

I see. But I still think that automated testing is a great opportunity
for the community to pinpoint problems.

Is there anything we can do to make thinks work better ?

-- 
paoloc.blogspot.com
