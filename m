Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262773AbSJCHZh>; Thu, 3 Oct 2002 03:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262775AbSJCHZh>; Thu, 3 Oct 2002 03:25:37 -0400
Received: from nl-ams-slo-l4-02-pip-6.chellonetwork.com ([213.46.243.24]:13853
	"EHLO amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id <S262773AbSJCHZf>; Thu, 3 Oct 2002 03:25:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jos Hulzink <josh@stack.nl>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Eriksson Stig <stig.eriksson@sweco.se>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx problems?
Date: Thu, 3 Oct 2002 09:31:00 +0200
X-Mailer: KMail [version 1.3.1]
References: <E50A0EFD91DBD211B9E40008C75B6CCA01497EDD@ES-STH-012> <20021002225057.TYEL1314.amsfep11-int.chello.nl@there> <4119940000.1033601617@aslan.btc.adaptec.com>
In-Reply-To: <4119940000.1033601617@aslan.btc.adaptec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021003073101.IJMM2173.amsfep13-int.chello.nl@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 October 2002 01:33, Justin T. Gibbs wrote:
> > On Wednesday 02 October 2002 19:10, Justin T. Gibbs wrote:
> >
> > I guess there is something seriously wrong in the driver then: my SCSI
> > cdrom  writers have the same problem. Result: lots of bad CDs.
> >
> > Jos
>
> I would have to see the messages to say.

Unfortunately all 2.5 log files are gone since the improved IDE driver did 
some non-deterministic sector destruction. I'm compiling 2.5.40 at the 
moment. I'll try to reproduce the errors.

Jos

