Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751757AbWCFQbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbWCFQbq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 11:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbWCFQbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 11:31:46 -0500
Received: from smtp17.wanadoo.fr ([193.252.23.111]:15097 "EHLO
	smtp17.wanadoo.fr") by vger.kernel.org with ESMTP id S1751397AbWCFQbp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 11:31:45 -0500
X-ME-UUID: 20060306163143804.C47527000094@mwinf1712.wanadoo.fr
Date: Mon, 6 Mar 2006 17:31:42 +0100
From: Mathieu Chouquet-Stringer <mchouque@free.fr>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
       Christoph Hellwig <hch@lst.de>, Richard Henderson <rth@twiddle.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Problem on Alpha with "convert to generic irq framework"
Message-ID: <20060306163142.GA19833@localhost>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@free.fr>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Richard Henderson <rth@twiddle.net>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20060304111219.GA10532@localhost> <20060306155114.A8425@jurassic.park.msu.ru> <20060306135434.GA12829@localhost> <20060306191324.A1502@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060306191324.A1502@jurassic.park.msu.ru>
User-Agent: Mutt/1.4.2.1i
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 07:13:24PM +0300, Ivan Kokshaysky wrote:
> No, thanks. I've finally found the AlphaBIOS ROM image for lx164,
> that was most difficult part of the work. ;-)

lol, I wish I could switch to srm but it just doesn't work...

> Now I'm able to kill the box in just one second with 'ping -f'...

Awesome (well in a way)...

> Will look into this tomorrow.

Thanks Ivan!!!

-- 
Mathieu Chouquet-Stringer                           mchouque@free.fr
    "Le disparu, si l'on vénère sa mémoire, est plus présent et
                 plus puissant que le vivant".
           -- Antoine de Saint-Exupéry, Citadelle --

