Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUFPRCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUFPRCd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 13:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbUFPRCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 13:02:32 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:28137 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S264246AbUFPQ7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 12:59:25 -0400
Subject: Re: 3ware 9500S Drivers (mm kernel)
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Peter Maas <fedora@rooker.dyndns.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001101c4531c$7a7c6960$3205a8c0@pixl>
References: <001101c4531c$7a7c6960$3205a8c0@pixl>
Content-Type: text/plain
Message-Id: <1087405618.8592.12.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 16 Jun 2004 19:06:58 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-15 at 23:05, Peter Maas wrote:
> I've been using the 3ware 9500 drivers in the mm kernel for a while now
> without any problems, this is on a dual opteron with a 9500S-12 controller
> with 6 disk formatted as a raid-5. Are these going to be included in the
> vanilla kernel soon?
> 
> My only complaints with the drivers are that smartctl doesnt work with them
> (fedora core 2), and the 3ware management tools from the 3ware cd wont work
> with the mm drivers (wont detect controller).
> 
> Thanks
> 
> Peter Maas
> 
smartctl doesn't work with the original 3ware 2.6 source drivers either.
3dm2 works though. Maybe you can check what the differences are between
the mm driver and the 3ware one?

There also should be an updated 2.6 source driver available from 3ware
by now.

Jurgen

