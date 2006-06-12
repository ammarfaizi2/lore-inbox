Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWFLIbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWFLIbt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 04:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWFLIbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 04:31:49 -0400
Received: from ns.firmix.at ([62.141.48.66]:8350 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1750867AbWFLIbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 04:31:48 -0400
Subject: Re: VGER does gradual SPF activation (FAQ matter)
From: Bernd Petrovitsch <bernd@firmix.at>
To: jdow <jdow@earthlink.net>
Cc: davids@webmaster.com, linux-kernel@vger.kernel.org
In-Reply-To: <00de01c68df9$7d2b2330$0225a8c0@Wednesday>
References: <MDEHLPKNGKAHNMBLJOLKEEFGMHAB.davids@webmaster.com>
	 <193701c68d16$54cac690$0225a8c0@Wednesday>
	 <1150100286.26402.13.camel@tara.firmix.at>
	 <00de01c68df9$7d2b2330$0225a8c0@Wednesday>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 12 Jun 2006 10:31:42 +0200
Message-Id: <1150101102.26402.28.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.332 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 01:23 -0700, jdow wrote:
[...]
> And just recently we received a spate of spam that came from a domain
> that disappeared almost immediately. Domain names are cheap. They can
> vouch for the spam run. Then what happens to them doesn't matter. But
> the SPF record passes.

Of course this is one way around it (and there are certainly others).
But it (may) save "my" domains from false complaints and bounced emails
just because some spammer sends email "From: xxx@mydomain".
Yes, SPF does not avoid spam in general (and BTW nobody on openspf.org
claims that).
And yes, we all want such a thing, but AFAICS there won't be such a
thing (except making email - at least - as expensive as snail mail).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

