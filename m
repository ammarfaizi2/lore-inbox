Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWFLISM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWFLISM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 04:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWFLISM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 04:18:12 -0400
Received: from ns.firmix.at ([62.141.48.66]:6302 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1750700AbWFLISL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 04:18:11 -0400
Subject: Re: VGER does gradual SPF activation (FAQ matter)
From: Bernd Petrovitsch <bernd@firmix.at>
To: jdow <jdow@earthlink.net>
Cc: davids@webmaster.com, linux-kernel@vger.kernel.org
In-Reply-To: <193701c68d16$54cac690$0225a8c0@Wednesday>
References: <MDEHLPKNGKAHNMBLJOLKEEFGMHAB.davids@webmaster.com>
	 <193701c68d16$54cac690$0225a8c0@Wednesday>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 12 Jun 2006 10:18:06 +0200
Message-Id: <1150100286.26402.13.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.331 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-10 at 22:17 -0700, jdow wrote:
[...]
> that matter. It simply says, "When I went and looked at the guy's claimed
> mail source the spf record said he was who he said he was." Who vouches

No. SPF simply defines legitimate outgoing MTAs for a given domain.
Within a domain, it is up to the postmaster to allow/disallow address
forgery and for the rest of a world (to tell where legitimate email of
his domain comes from), the postmaster defines SPF records.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

