Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbVKHM1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbVKHM1q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 07:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbVKHM1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 07:27:46 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:60336 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964999AbVKHM1p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 07:27:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W36XLKYqQX1npfCh0N+04oNuAB3qQEdJ4t31QUvXNg9fptbYDLfr/AGWPOgmH2WOBWDmvUxVP3LwT2eh03LlMH21ou5pEDO4B/5k0uaEX7Y3yhsqNowGX8p/xmh2aup1/7bCq5uhrGtZtGeRCVQYc3fGnS7jtvT4sCQhgaAQKl8=
Message-ID: <5bdc1c8b0511080427jd216a33sc70da7f9e2a4fe27@mail.gmail.com>
Date: Tue, 8 Nov 2005 04:27:43 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: NVidia nForce4 + AMD Athlon64 X2 --> no access to north-bridge PCI resources
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051108085031.GG5706@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051107225755.GE5706@mea-ext.zmailer.org>
	 <5bdc1c8b0511071620o2032c85crd45a4777aae4b971@mail.gmail.com>
	 <20051108085031.GG5706@mea-ext.zmailer.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/05, Matti Aarnio <matti.aarnio@zmailer.org> wrote:
> On Mon, Nov 07, 2005 at 04:20:09PM -0800, Mark Knecht wrote:
> > On 11/7/05, Matti Aarnio <matti.aarnio@zmailer.org> wrote:
> > >
> > > This problem machine is  ASUS A8N-SLI Premium
> > > AMD CPU family/model/stepping: 15/35/2
> > >
> > > The question is:
> > >
> > >   Where are "host bridge" subsystem things in this new
> > >   ASUS board with NVidia nForce4 ?
> >
> > Interesting. Here's another NForce4 from Asus - A8N-E. It does not
> > show the problem you observe:
>
> What processor do you have ?
> If anybody with any A8N-SLI variant would see the "host bridge" resources,
> then things would be most interesting..

I bought an inexpensive processor when I built this machine in late
August. I would be interested in finding out how much faster this
machine could go with a more expensive version:

AMD Athlon 64 3000+ Venice 1GHz FSB 512KB L2 Cache Socket 939 Processor

http://www.newegg.com/Product/Product.asp?Item=N82E16819103537

- Mark
