Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752170AbWCJISY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbWCJISY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 03:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbWCJISY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 03:18:24 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:15556 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S1751179AbWCJISY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 03:18:24 -0500
Date: Fri, 10 Mar 2006 09:19:38 +0100
From: DervishD <lkml@dervishd.net>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Rudolf Randal <rudolf.randal@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [future of drivers?] a proposal for binary drivers.
Message-ID: <20060310081938.GB14695@DervishD>
Mail-Followup-To: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Rudolf Randal <rudolf.randal@gmail.com>,
	linux-kernel@vger.kernel.org
References: <161717d50603080659t53462cd0k53969c0d33e06321@mail.gmail.com> <a03c9a270603090242o713fbe36s895da175bc53140f@mail.gmail.com> <20060309112241.GC14004@DervishD> <200603091834.43636.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200603091834.43636.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Alistair :)

 * Alistair John Strachan <s0348365@sms.ed.ac.uk> dixit:
> On Thursday 09 March 2006 11:22, DervishD wrote:
> >     I haven't got any answer from them. I can use other glucometer,
> > of course, but this one is, IMHO, the best one in the market and I
> > don't think any other vendor would give me specs for their products.
> 
> Sounds like reverse engineering territory. Fortunately there is
> software for windows that can help you reverse engineer USB or
> serial-over-USB protocols fairly easily. I doubt such a device
> would be difficult to write a driver for.

    Not difficult at all, once you build the cable (it's not a
standard USB cable), but I don't want to do reverse engineering this
time. Adding Linux support to this device will help the manufacturer
(probably a very tiny little help, but help nonetheless), who doesn't
seem to care enough of their users.

    I mean, the vendor is earning lots of money from me (not due to
the device, but to the supplies I need daily), so if they don't want
to collaborate (at no cost from them) to add Linux support, I'll just
use another glucometer that will give support. Here in Spain, all
glucometer-makers are more than happy to get my Menarini glucometer
and give me one of theirs at no charge (given that they will get the
money from the supplies). I can try almost all vendors. It's a pity,
because I think this meter is the best one in the market, but if I
have to use another product in order to have it supported by Linux,
I'll do, and I will advice others against the product I just
rejected.
 
> In my opinion, no answer isn't a good enough answer.

    I think the same. They may have very good reasons to not give the
specs, and I can understand them... if they tell me! Currently, I can
only make guesses about the reasons...

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to... RAmen!
