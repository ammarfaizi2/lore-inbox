Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWCWLYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWCWLYn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 06:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWCWLYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 06:24:43 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:21419 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751053AbWCWLYm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 06:24:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bwxjcMpny7N6qpcN8PaJuquIstnLScdTKkyiyPgQC/fU7xziWYC/9Jh9H7DK6ydR96vwNRVyrVlZjofX27pVYb1myPzJSVt+nJGok/aw1MSL3EwWhp2bYATvlEJdgneRxfxLLN2ulEigxtb5LzSf+7mW/Xrh5YJ75apgxRJaB/w=
Message-ID: <b8bf37780603230324x615b6dc9xc0319d1feb7b0a65@mail.gmail.com>
Date: Thu, 23 Mar 2006 07:24:42 -0400
From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
To: "Con Kolivas" <kernel@kolivas.org>
Subject: Re: [ck] swap prefetching merge plans
Cc: "Andrew Morton" <akpm@osdl.org>, ck@vds.kolivas.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200603231804.36334.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20060322205305.0604f49b.akpm@osdl.org>
	 <200603231804.36334.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/06, Con Kolivas <kernel@kolivas.org> wrote:
> On Thu, 23 Mar 2006 03:53 pm, Andrew Morton wrote:
> > A look at the -mm lineup for 2.6.17:
>
> > mm-implement-swap-prefetching.patch
> > mm-implement-swap-prefetching-fix.patch
> > mm-implement-swap-prefetching-tweaks.patch
>
> >   Still don't have a compelling argument for this, IMO.
>
> For those users who feel they do have a compelling argument for it, please
> speak now or I'll end up maintaining this in -ck only forever.  I've come to
> depend on it with my workloads now so I'm never dropping it. There's no point
> me explaining how it is useful yet again, though, because I just end up
> looking like I'm handwaving. It seems a shame for it not to be available to
> all linux users.

It makes my desktop usable in the morning for sure, I feel that it
makes difference to me.

Best regards,
--
[]s,

André Goddard
