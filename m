Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267164AbUIRPEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267164AbUIRPEX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 11:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269532AbUIRPEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 11:04:23 -0400
Received: from goose.mail.pas.earthlink.net ([207.217.120.18]:53677 "EHLO
	goose.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S267164AbUIRPEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 11:04:21 -0400
Subject: Re: open source realtek driver for 8180
From: David Hollis <dhollis@davehollis.com>
Reply-To: dhollis@davehollis.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: tuxrocks@cox.net, linux-kernel@vger.kernel.org
In-Reply-To: <20040918002931.GA5327@logos.cnet>
References: <20040915161113.BVQI25194.lakermmtao01.cox.net@smtp.east.cox.net>
	 <1095268473.6499.4.camel@dhollis-lnx.kpmg.com>
	 <200409151954.18035.tuxrocks@cox.net>  <20040918002931.GA5327@logos.cnet>
Content-Type: text/plain
Date: Sat, 18 Sep 2004 11:04:33 -0400
Message-Id: <1095519873.3696.5.camel@dhollis-lnx.kpmg.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-17 at 21:29 -0300, Marcelo Tosatti wrote:
> In my experience the realtek binary driver is crap - it brings up the card 
> and transfers data correctly - but stops communication after some period of time, 
> sometimes 10 minutes, sometimes 1 hour.
> 
> It oopses on card removal, doenst handle anything other than normal 
> operation for more than 1 hour.
> 
> On RH's 2.4.20-8, all of that.

I'm dabbling with the rtl8180-sa2400 code to see if I can make it do
anything.  Right now most of my time is spent making it compile and
remotely legible.  The coding style is quite far from graceful.
Hopefully I can get it to at least transfer some packets and make more
use of the community to get into something of quality.  

I haven't worked with wireless drivers yet so thats a learning
experience but at least there are plenty of examples at this point.

-- 
David Hollis <dhollis@davehollis.com>

