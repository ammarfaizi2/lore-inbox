Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbVBYL7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbVBYL7c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 06:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbVBYL7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 06:59:32 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:58521 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262683AbVBYL7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 06:59:19 -0500
Message-ID: <49984.195.126.66.126.1109332744.squirrel@housecafe.dyndns.org>
In-Reply-To: <20050225063609.GA21244@pegasos>
References: <20041206185416.GE7153@smtp.west.cox.net>
    <Pine.SOC.4.61.0502221031230.6097@math.ut.ee>
    <20050224074728.GA31434@pegasos>
    <Pine.SOC.4.61.0502241746450.21289@math.ut.ee>
    <20050224160657.GB11197@pegasos> <421E7033.1030600@g-house.de>
    <20050225063609.GA21244@pegasos>
Date: Fri, 25 Feb 2005 12:59:04 +0100 (CET)
Subject: Re: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII 
     Utah) PCI IRQ map
From: "Christian" <evil@g-house.de>
To: "Sven Luther" <sven.luther@wanadoo.fr>
Cc: "Christian Kujau" <evil@g-house.de>,
       "Tom Rini" <trini@kernel.crashing.org>, "Meelis Roos" <mroos@linux.ee>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org, "Sven Hartge" <hartge@ds9.gnuu.de>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, February 25, 2005 7:36, Sven Luther said:
> So, now, we need to find out what the problems where, i think it is
> something that went in between 2.6.8 and 2.6.10, and leigh said he had
> some ideas.

may i ask what patches were applied to a vanilla 2.6.8 kernel to build the
2.6.8-d-i then?

thanks,
Christian.
-- 
make bzImage, not war

