Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbVKOIh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbVKOIh7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 03:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbVKOIh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 03:37:59 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:60502 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751370AbVKOIh7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 03:37:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TYWCo/QaHLH+bMdh1ZEYp4PlgDUzqxxZlS7NuFXjs2Ykd77x8FWaa8a0WuSQzx1BlopvnAAVf+Wtf09T8dveqccbOZjoAmRjBEqb6f2DTO4DRUXicrKGs5kEn0TnyKKuOp26TLbxQJPQFNGp44+MjrxuHOSHUD/RfvbBz0ZY5uc=
Message-ID: <4d8e3fd30511150037j63a479b5j7c38430f9f5ffedd@mail.gmail.com>
Date: Tue, 15 Nov 2005 09:37:58 +0100
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] HOWTO do Linux kernel development
Cc: Kalin KOZHUHAROV <kalin@thinrope.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20051115045857.GA2658@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051114220709.GA5234@kroah.com> <20051114221005.GA5539@kroah.com>
	 <4379295B.1020601@thinrope.net> <20051115045857.GA2658@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/05, Greg KH <greg@kroah.com> wrote:
> On Tue, Nov 15, 2005 at 09:18:35AM +0900, Kalin KOZHUHAROV wrote:
> > Greg KH wrote:
> > > On Mon, Nov 14, 2005 at 02:07:09PM -0800, Greg KH wrote:
> > >
> > >>So, I've been working on a document for the past week or so to help
> > >>alleviate a lot of these problems.
> > >
> > >
> > > Oh, the latest version can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/gregkh/patches.git;a=blob;f=HOWTO
> > > as I'm keeping it in my git patch tree.
> >
> > As far as the development proces is in TODO state, what about adding
> > Paolo Ciarrocchi's (CCed) doc there?
> >       http://linux.tar.bz/articles/2.6-development_process
>
> Ah, a very nice summary.
>
> Paolo, can I use this document as a base for this section in the HOWTO
> file (with proper attribution of course.)

Yup!
Of course you can.

--
Paolo
