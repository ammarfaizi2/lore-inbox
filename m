Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130027AbQLTS3G>; Wed, 20 Dec 2000 13:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbQLTS24>; Wed, 20 Dec 2000 13:28:56 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:36873 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S130027AbQLTS2l>; Wed, 20 Dec 2000 13:28:41 -0500
Date: Wed, 20 Dec 2000 18:58:07 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/random: really secure?
Message-ID: <20001220185807.A22506@pcep-jamie.cern.ch>
In-Reply-To: <E148a7v-0001Ub-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E148a7v-0001Ub-00@calista.inka.de>; from ecki@lina.inka.de on Wed, Dec 20, 2000 at 04:41:15AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels wrote:
> In article <20001218213801.A19903@pcep-jamie.cern.ch> you wrote:
> > A potential weakness.  The entropy estimator can be manipulated by
> > feeding data which looks random to the estimator, but which is in fact
> > not random at all.
> 
> That's why feeding randomness is a priveledgedoperation.

I was referring to randomness influenced externally, e.g. network
packet timing, hard disk timing by choice of which http requests, etc.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
