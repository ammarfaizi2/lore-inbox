Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265000AbTFLVEn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 17:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265001AbTFLVEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 17:04:43 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:20491
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S265000AbTFLVEL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 17:04:11 -0400
Subject: Re: Intel PRO/Wireless 2100 vs. Broadcom BCM9430x
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Anders Karlsson <anders@trudheim.com>
Cc: Joel Jaeggli <joelja@darkwing.uoregon.edu>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1055450268.3989.27.camel@tor.trudheim.com>
References: <Pine.LNX.4.44.0306120813380.411-100000@twin.uoregon.edu>
	 <1055450268.3989.27.camel@tor.trudheim.com>
Content-Type: text/plain
Message-Id: <1055452675.13998.2.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 12 Jun 2003 14:17:55 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 13:37, Anders Karlsson wrote:
> And that is if your laptop will allow such a card to be plugged in and
> used of course. Thinkpads with the tcpa chip in them might not allow
> such a card,

Nothing to do with TCPA: my laptop doesn't have one, and it objects to
"foreign" wireless cards.  Plain old BIOS is enough.

Fortunately IBM support the Cisco Airo 350 mini-pci card, and supply a
(GPLed) driver.  It isn't the greatest driver (no 2.5 port, seems flakey
when doing anything with the admin tool, no wireless extension support),
but it works enough to make wireless useful.

	J

