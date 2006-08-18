Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWHRJTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWHRJTx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 05:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWHRJTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 05:19:53 -0400
Received: from ns.firmix.at ([62.141.48.66]:26005 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751315AbWHRJTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 05:19:51 -0400
Subject: Re: GPL Violation?
From: Bernd Petrovitsch <bernd@firmix.at>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Ian Stirling <ian.stirling@mauve.plus.com>,
       Patrick McFarland <diablod3@gmail.com>,
       Anonymous User <anonymouslinuxuser@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1155891879.22871.191.camel@pmac.infradead.org>
References: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com>
	 <200608170242.40969.diablod3@gmail.com>
	 <1155807431.22871.157.camel@pmac.infradead.org>
	 <44E4FF89.3080500@mauve.plus.com>
	 <1155891183.22201.32.camel@tara.firmix.at>
	 <1155891879.22871.191.camel@pmac.infradead.org>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Fri, 18 Aug 2006 11:15:42 +0200
Message-Id: <1155892542.22201.45.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.379 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 10:04 +0100, David Woodhouse wrote:
> On Fri, 2006-08-18 at 10:53 +0200, Bernd Petrovitsch wrote:
> > If you tamper with the product "as you like" (read: in unintended
> > ways, not through officially available interfaces, etc.), there are
> > IMHO (in .at) no disclaimers necessary - the producer has no
> > responsibility any more from the moment you start tampering. 
> 
> No responsibility under warranty, I agree. But that's entirely

And there are several other aspects (at least in .at).

> irrelevant to the discussion at hand, as far as I can tell.

OK.

> Your tampering does _not_ mean that they no longer have to comply with
> the licence terms of the software they've shipped on the device. If it's

Of course (sorry, that was apparently not enough).

> Windows, they still need to pay Microsoft for it. And if it's Linux they
> still need to release all the relevant source code.

Probably more on-topic:
We have law people in .at who think/propose/have the opinion that one
entity as seen by the user/consumer has one license. So if you pack a
GPL program on it, the whole entity is GPL.
Given the current common method of providing one firmware image per
device for download to upgrade/bugfix, the producer of that image must
adhere to the GPL for *all+ of the source code of that image (+
necessary toolchain etc.).
The reasoning is: The user/consumer sees one thing and that's it.

If such an interpretation is "good" or "bad" (and for whom) is another
question.
The counter strategies to work around that are probably obvious.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

