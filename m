Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263036AbREaJHL>; Thu, 31 May 2001 05:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263038AbREaJHB>; Thu, 31 May 2001 05:07:01 -0400
Received: from pD951F2B7.dip.t-dialin.net ([217.81.242.183]:2053 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S263036AbREaJGs>; Thu, 31 May 2001 05:06:48 -0400
Date: Thu, 31 May 2001 10:44:37 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.5 still breaks dhcpcd with 8139too
Message-ID: <20010531104437.C10057@emma1.emma.line.org>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010529215647.A3955@greenhydrant.com> <3B147F80.31EC7520@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B147F80.31EC7520@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, May 30, 2001 at 01:05:04 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Jeff Garzik wrote:

> > I see that Alan has reverted back to the 2.4.3 driver for his ac-series for
> > other reasons, hopefully either the old driver will going in to 2.4.6 or the
> > new one will get fixed?
> 
> I've got one of the two problems fixed here at the test lab, and am
> working on the second.  Hopefully this week I'll have this sorted out,
> and a driver for you guys to test.

Will that 8139too be able to share its IRQ with a bttv card (Hauppauge
WinTV in my case)? With 2.2.19, it's currently possible, at least after
unloading and reloading the 8139too module, but it's a no-go with 2.4.5.
