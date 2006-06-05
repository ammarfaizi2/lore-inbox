Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750877AbWFEKST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWFEKST (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 06:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWFEKST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 06:18:19 -0400
Received: from mout1.freenet.de ([194.97.50.132]:50579 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1750875AbWFEKSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 06:18:18 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: Dag Arne Osvik <da@osvik.no>
Subject: Re: [PATCH  4/4] Twofish cipher - x86_64 assembler
Date: Mon, 5 Jun 2006 12:18:15 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au
References: <200606041516.46920.jfritschi@freenet.de> <200606042110.15060.ak@suse.de> <44834A0F.3000502@osvik.no>
In-Reply-To: <44834A0F.3000502@osvik.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606051218.16125.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 June 2006 23:01, Dag Arne Osvik wrote:
> Andi Kleen wrote:
> > On Sunday 04 June 2006 15:16, Joachim Fritschi wrote:
> >> This patch adds the twofish x86_64 assembler routine.
> >>
> >> +/* Defining a few register aliases for better reading */
> >
> > Maybe you can read it now better, but for everybody else it is extremly
> > confusing. It would be better if you just used the original register
> > names.
>
> I'd agree if you said this code could benefit from further readability
> improvements.  But you're arguing against one.
>
> Too bad AMD kept the old register names when defining AMD64..

I'd agree that the original register names would only complicate things. 

Can you give me any hint what to improve or maybe provide a suggestion on how 
to improve the overall readabilty.

Thanks,

Joachim

