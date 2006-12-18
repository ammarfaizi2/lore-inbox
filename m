Return-Path: <linux-kernel-owner+w=401wt.eu-S1753681AbWLRJvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbWLRJvj (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 04:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753679AbWLRJvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 04:51:39 -0500
Received: from ns.firmix.at ([62.141.48.66]:54618 "EHLO ns.firmix.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753677AbWLRJvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 04:51:38 -0500
Subject: Re: Binary Drivers
From: Bernd Petrovitsch <bernd@firmix.at>
To: James Porter <jameslporter@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <loom.20061215T220806-362@post.gmane.org>
References: <loom.20061215T220806-362@post.gmane.org>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 18 Dec 2006 10:51:31 +0100
Message-Id: <1166435491.13376.6.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.41 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-15 at 21:20 +0000, James Porter wrote:
> I think some kernel developers take to much responsibility, is there a bug in a
> binary driver? Send it upstream and explain to the user that it's a closed

Plaese name them. AFAICS if there is a response, it is similar to "your
kernel is tainted, please report the report elsewhere".

> source driver and is up to said company to fix it.
> 
> For what it's worth, I don't see any problem with binary drivers from hardware
> manufacturers. 

You are probably not looking at the right places.

> Just because nvidia makes a closed source driver doesn't mean that we can't also

^^
Please send patches.

> create an open source driver(limited functionality, reverse engineered,
> etc.,etc.). I firmly believe that the choice should be up to the user and/or
> distro. I'm not a kernel dev, I don't know c...but I understand the concepts and
                                        ^^^^^^^^^^
Then become one if you are serious with the "we" above.

> I should have the right to do what I want with this GPL code. Restricting me

Then you should discuss this with law makers, politicians and the
various pressure groups about copyright and/or authors rights and you
surely *must* deal beforehand with the patent plague since this is even
more restricting in any sense than author rights ever was (let alone
copyright).
And for such  political debate LKML is probably not a good place.

> only frustrates me. Should the default be open source, definitely; should binary
> drivers be blocked from running on a linux kernel...certainly not.

They are not blocked - it is up to the users to decide and live with the
consequences.

[...]
> only to have the rug pulled out from under you. This is what makes the BSDs so
> attractive.

Why are you then here?

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

