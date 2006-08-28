Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWH1Jvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWH1Jvx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 05:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWH1Jvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 05:51:53 -0400
Received: from ns.firmix.at ([62.141.48.66]:35535 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932485AbWH1Jvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 05:51:52 -0400
Subject: Re: [OT] Re: Server Attack
From: Bernd Petrovitsch <bernd@firmix.at>
To: altendew <andrew@shiftcode.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6014622.post@talk.nabble.com>
References: <6011508.post@talk.nabble.com>
	 <20060827171125.5e1a0a60.largret@gmail.com> <6014209.post@talk.nabble.com>
	 <6014456.post@talk.nabble.com> <20060828043951.GQ8776@1wt.eu>
	 <6014622.post@talk.nabble.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 28 Aug 2006 11:51:40 +0200
Message-Id: <1156758701.17712.34.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.38 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-27 at 22:05 -0700, altendew wrote:
> To be quite honest in the end this will keep adding IPs. This russian guy who

Yup, that the intention if you you want to block these attacks.

> is DDOS me is sending 40 requests per second. The problem is all the IPs are
> different and I dont feel safe rejected all the IPs. I looked up the IPs on
> an IPWhois and most of the same they are a "Autonomous System" wtf is that?

I don't understand the last line:  Do you mean that all of the IP
addresses are from the the same AS?
Then you have only to deide if you want to block the AS.

As for what an AS is:
http://en.wikipedia.org/wiki/Autonomous_system_(Internet)
http://searchnetworking.techtarget.com/sDefinition/0,,sid7_gci213662,00.html


[ Fullquote deleted ]

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

