Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030496AbVIOPWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496AbVIOPWU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 11:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbVIOPWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 11:22:20 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:32269 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S1030493AbVIOPWT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 11:22:19 -0400
To: Rakotomandimby Mihamina 
	<mihamina.rakotomandimby@etu.univ-orleans.fr>
Cc: linux-kernel@vger.kernel.org, Nick Warne <nick@linicks.net>
Subject: Re: RTL8139, the final patch ?
References: <200508202153.17837.nick@linicks.net>
	<200508202317.46937.nick@linicks.net>
	<87pss8cf2z.fsf@devron.myhome.or.jp>
	<1126718168.2339.6.camel@localhost.localdomain>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 16 Sep 2005 00:21:56 +0900
In-Reply-To: <1126718168.2339.6.camel@localhost.localdomain> (Rakotomandimby Mihamina's message of "Wed, 14 Sep 2005 19:16:07 +0200")
Message-ID: <871x3qwe3v.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rakotomandimby Mihamina <mihamina.rakotomandimby@etu.univ-orleans.fr> writes:

> Well, my computer is a notebook (CompaQ R4000), with a very restricted
> set of settings in the BIOS. I cannot deactivate what Nick Warne told.
> Desactivate acpi on a notebook is a bit frustrating :-)
> The only solution would be to apply the patch. 

This seems not edge/level triggered problem. Probably, IRQ routing or
somethig. Since I don't know ATI chipset at all, I'm not
helpful man. Sorry.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
