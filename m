Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269250AbRHTUqA>; Mon, 20 Aug 2001 16:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269274AbRHTUpu>; Mon, 20 Aug 2001 16:45:50 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:11916 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S269250AbRHTUpa>; Mon, 20 Aug 2001 16:45:30 -0400
Date: Mon, 20 Aug 2001 22:45:36 +0200
From: Cliff Albert <cliff@oisec.net>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx errors with 2.4.8-ac7 on 440gx mobo
Message-ID: <20010820224536.A28179@oisec.net>
In-Reply-To: <20010820105520.A22087@oisec.net> <200108202027.f7KKRnY41946@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200108202027.f7KKRnY41946@aslan.scsiguy.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2001 at 02:27:49PM -0600, Justin T. Gibbs wrote:

> >I'm getting similair errors on 2.4.8-ac7 on my P2B-S motherboard using
> >the NEW AIC7xxx driver, the old isn't experiencing these problems. Further
> >i've been getting these errors since 2.4.3.
> >
> >> booting with append="noapic", gives the same errors
> 
> Can you send me the full messages when you boot with "aic7xxx=verbose"?
> That should help indicate the source of your problems.  I also
> need to see the devices that are attached to the bus, so a full dmesg
> from a successful boot with the old driver would be helpful.

Well booting is successful on my board, but the same errors that almost
everyone is getting are the same i'm getting. I just turned on verbose.

Most debugging info i already send to the linux-kernel mailinglist, i'll
forward it on to you. The verbose info will be send also in about a few 
hours.

-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | www.oisec.net
cliff@oisec.net		| 6BONE:     CA2-6BONE	 | icq 18461740
