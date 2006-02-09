Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWBIVGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWBIVGf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 16:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWBIVGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 16:06:35 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:38373 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750781AbWBIVGe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 16:06:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lM3P12ijw7x8gyENsZwZq3H6X/AID9xVdUxZtvw45Qi7jTYxOxldKl0d2fsyTm8mXrOxTCtQqPhZkguiLZ4HDDbxVN+C/dOcmIqRWSasgAjPlebonqU0TBF9Wvt/3dobABEP/CpkeSltobLeYiq79E+3XyJnlRcCsgA5ZNOeQuA=
Message-ID: <9a8748490602091306x1773a438p94cbc50f004a5b8f@mail.gmail.com>
Date: Thu, 9 Feb 2006 22:06:33 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [PATCH] Megaraid cleanup
Cc: "Ju, Seokmann" <Seokmann.Ju@lsil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Kolli, Neela" <Neela.Kolli@engenio.com>, linux-scsi@vger.kernel.org
In-Reply-To: <9a8748490601251322nc1f1b7di3c02444f66fbe625@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9738BCBE884FDB42801FAD8A7769C265142031@NAMAIL1.ad.lsil.com>
	 <9a8748490601240741x5a54db53o37dcf46cf25d5420@mail.gmail.com>
	 <1138122353.3662.7.camel@mulgrave>
	 <9a8748490601251322nc1f1b7di3c02444f66fbe625@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 1/24/06, James Bottomley <James.Bottomley@steeleye.com> wrote:
> > On Tue, 2006-01-24 at 16:41 +0100, Jesper Juhl wrote:
> > > I assume you'll take care of pushing it forward or should I do that?
> >
> > I can't actually find this patch on the SCSI list, so resending it would
> > be a good start.
> >
> Hmm, I guess it never made it due to size.
>
> Below is the description I initially wrote for the patch and the patch
> itself is attached as a bzip2 archive so it will hopefully make it to
> you.
>

James: any comments on the patch?
Any chance it'll be applied to mainline?
If there's anything you want/need me to redo then please just let me
know and I'll be happy to work out any issues there might be.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
