Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292965AbSB1N7t>; Thu, 28 Feb 2002 08:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293339AbSB1N5S>; Thu, 28 Feb 2002 08:57:18 -0500
Received: from smtp1.ndsu.NoDak.edu ([134.129.111.146]:20999 "EHLO
	smtp1.ndsu.nodak.edu") by vger.kernel.org with ESMTP
	id <S293342AbSB1N4D>; Thu, 28 Feb 2002 08:56:03 -0500
Subject: Re: Kernel module ethics.
From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
To: lachinois@hotmail.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C7DFB9C.6A9F41F5@aitel.hist.no>
In-Reply-To: <F82zxvoEaZWNaBJjvmZ00001183@hotmail.com> 
	<3C7DFB9C.6A9F41F5@aitel.hist.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 28 Feb 2002 07:55:57 -0600
Message-Id: <1014904559.11411.11.camel@zeus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-02-28 at 03:42, Helge Hafting wrote:
> How can a closed-source driver help you?  Even such a driver may be
> pirated and used on the competitors card.  But you choose to trust
> people in that situation.  If you trust people that much you might
> as well release an open-source driver with a clause that it may only
> be used with _your_ company's cards.  Or provide the _firmware_
> with a strict licence and trust they don't pirate that.
> 
> The ideal way (for us customers) is if your company and the others with
> similiar hardware agree on sharing the development cost of a 
> GPL driver.  Nobody loose from paying for a driver the others can use.
> Capitalist competition is still possible:
> * extra features, quality & reliability are selling points
> * pricing, advertising
> * trying to manufacture in cheaper ways than the others
> 
> Sharing the cost of development makes a lot of sense because the
> others *will* come up with their own linux drivers anyway if
> it turns out to be money in selling hardware to linux users.
> All loose by making separate drivers.

Another possibility in this same vein is if you're a board level
manufacturer integrating somebody elses silicon, prod the chip
manufacturer to help with a driver (GPLed code, docs, whatever). It
costs you very little, and you get to claim Linux support. If your extra
(binary) firmware only works with your card (technical or market
reasons, doesn't matter) you aren't giving away the store any more than
with a closed driver.

Regards 

