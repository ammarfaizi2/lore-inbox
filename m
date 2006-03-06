Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWCFNzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWCFNzJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 08:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWCFNzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 08:55:08 -0500
Received: from smtp17.wanadoo.fr ([193.252.23.111]:16104 "EHLO
	smtp17.wanadoo.fr") by vger.kernel.org with ESMTP id S932318AbWCFNzG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 08:55:06 -0500
X-ME-UUID: 20060306135459485.766267000084@mwinf1701.wanadoo.fr
Date: Mon, 6 Mar 2006 14:54:34 +0100
From: Mathieu Chouquet-Stringer <mchouque@free.fr>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
       Christoph Hellwig <hch@lst.de>, Richard Henderson <rth@twiddle.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Problem on Alpha with "convert to generic irq framework"
Message-ID: <20060306135434.GA12829@localhost>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@free.fr>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Richard Henderson <rth@twiddle.net>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20060304111219.GA10532@localhost> <20060306155114.A8425@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060306155114.A8425@jurassic.park.msu.ru>
User-Agent: Mutt/1.4.2.1i
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 03:51:14PM +0300, Ivan Kokshaysky wrote:
> I cannot reproduce that, but all my machines use SRM, so interrupt
> handling is quite different from AlphaBIOS systems.
> [...]
> I'll try to install AlphaBIOS/MILO on my lx164 to see what happens.

Too bad my alpha doesn't support SRM (it's really a modified LX164
board).

Is there anything I can do to help debug the problem?
-- 
Mathieu Chouquet-Stringer                           mchouque@free.fr
    "Le disparu, si l'on vénère sa mémoire, est plus présent et
                 plus puissant que le vivant".
           -- Antoine de Saint-Exupéry, Citadelle --

