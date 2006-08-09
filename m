Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWHIQcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWHIQcS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWHIQcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:32:18 -0400
Received: from animx.eu.org ([216.98.75.249]:26512 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S1750723AbWHIQcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:32:18 -0400
Date: Wed, 9 Aug 2006 12:28:48 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Folkert van Heusden <folkert@vanheusden.com>,
       David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Time to forbid non-subscribers from posting to the list?
Message-ID: <20060809162848.GA12306@animx.eu.org>
Mail-Followup-To: Matti Aarnio <matti.aarnio@zmailer.org>,
	Folkert van Heusden <folkert@vanheusden.com>,
	David Schwartz <davids@webmaster.com>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <44D871DE.1040509@garzik.org> <MDEHLPKNGKAHNMBLJOLKIECNNKAB.davids@webmaster.com> <20060809143429.GD5815@vanheusden.com> <20060809150851.GH3021@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809150851.GH3021@mea-ext.zmailer.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:
> I have seen these lists classify major ISP relays as spam sources(*),
> even classify VGER as one.  Their maintenance standards are varying,
> some demand ridiculous things out of DNS zone SOA timers, some are
> otherwise retarded in their "we are the world police, beware or be
> sorry"..   and then they simply evaporate into the bit heaven.

Be nice if those that get listed and have real spammer problems actually
clean up.  Some don't care.

> Spamhouse and Spamcop have long(er) existence compared to most
> DNS BLs, but still I am utterly worried...
> ("Many times burned, forever distrustful..")

Personally, I use several RBLs, spamhaus and spamcop being 2 of those.

If it's possible, one suggesting I have is to filter out some HELO strings.
I have 3 of those in my suggestion:
1) strings consisting of either the IP or the hostname of the receiving
server (vger.kernel.org I assume)
2) any helo that does not contain a dot.  I do not know the impact on the
list if that were used
3) tom.com and 163.com.  I have noticed that these are very common in some
of the spam on the list and others that I am on.

These are only suggestions and I do not expect anyone to blindly use them. 
I do use these methods and others, however, I am the only user of the mail
server in which I'm sending this email.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
