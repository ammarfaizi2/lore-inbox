Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266611AbUJTHnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266611AbUJTHnB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 03:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270035AbUJTHh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 03:37:26 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:2918 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266611AbUJTHfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 03:35:38 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=R65IHscj1cHmVaW8+h560jiOhHSc5piv7GtcKjD030p2kKahmvw4Zawj7sUadKnfe9TWzRDgQaFCIC0x+9riOgsvJRa5/DPw502ruY/zoYl5pKpki5yYFBJ15LGh/PpqHHf3o3kvHKlizsUK3dLuwMZdhbI5X8mctrtNUIzjMGs
Message-ID: <4d8e3fd304102000355be4a2ef@mail.gmail.com>
Date: Wed, 20 Oct 2004 09:35:37 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: BK kernel workflow
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41752E53.8060103@pobox.com>
	 <20041019153126.GG18939@work.bitmover.com>
	 <41753B99.5090003@pobox.com>
	 <4d8e3fd304101914332979f86a@mail.gmail.com>
	 <20041019213803.GA6994@havoc.gtf.org>
	 <4d8e3fd3041019145469f03527@mail.gmail.com>
	 <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004 15:11:55 -0700 (PDT), Linus Torvalds
<torvalds@osdl.org> wrote:
> 
> 
> On Tue, 19 Oct 2004, Paolo Ciarrocchi wrote:
> >
> > I know I'm pedantic but can we all see the list of bk trees ("patches
> > ready for mainstream" and "patches eventually ready for mainstream")
> > that we'll be used by Linus ?
> 
> Even _I_ don't have that kind of list.
> 
> It's on a case-by-case basis (although with certain developers, the cases
> tend to be pretty clear-cut), and it literally changes over time. Some
> people use throw-away trees that are just used for some particular set,
> and I merge them (or not), and they go away.

So ATM is not possible to "formalize" the process (and probably even
not necessary)
Thank you.

-- 
Paolo
Personal home page: www.ciarrocchi.tk
