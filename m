Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbVILUNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbVILUNv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbVILUNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:13:50 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:48521 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750840AbVILUNt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:13:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PteC4UpCi5gv42buk7ivbF9uvSNbuYStSDR67vJKvBiVen424O9bcYGfoLDBE0ijIQ/nQUY/6gwSNUg2G5DWMgGTa/s6wblZk4Zps8hBiLtV6tC5Wt+i4bxuQpidaoh7ZdQVbpHJfPxULhp1XKds5cmY9FxgfFV0x2FPYkLH7zY=
Message-ID: <29495f1d05091213134d917bd7@mail.gmail.com>
Date: Mon, 12 Sep 2005 13:13:46 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: nish.aravamudan@gmail.com
To: paolo.ciarrocchi@gmail.com
Subject: Re: 2.6.13-mm3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <4d8e3fd305091208191fbbe804@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050912024350.60e89eb1.akpm@osdl.org>
	 <4d8e3fd305091208191fbbe804@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/05, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> On 9/12/05, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm3/
> >
> > (temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-mm3.gz)
> >
> > - perfctr was dropped.  Mikael has ceased development and recommends that
> >  the focus be upon perfmon.  See
> >  http://sourceforge.net/mailarchive/forum.php?thread_id=8102899&forum_id=2237
> >
> > - There are several performance tuning patches here which need careful
> >  attention and testing.  (Does anyone do performance testing any more?)
> 
> How about the tool announced months ago by Martin J. Bligh ?
> 
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html

Preferred location is: test.kernel.org (much shorter too!)

Also, the problem for -mm3 is that -mm2 did not build on most
machines. -mm1 did on 4/6. Probably some determination could be made
from those.

Thanks,
Nish
