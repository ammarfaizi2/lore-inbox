Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262623AbVA1TUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbVA1TUU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbVA1TTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:19:34 -0500
Received: from orb.pobox.com ([207.8.226.5]:50398 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262623AbVA1TKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:10:09 -0500
Subject: Re: [ANN] removal of certain net drivers coming soon:
	eepro100,?xircom_tulip_cb, iph5526
From: Scott Feldman <sfeldma@pobox.com>
Reply-To: sfeldma@pobox.com
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1CuSUy-00063X-LK@rhn.tartu-labor>
References: <E1CuSUy-00063X-LK@rhn.tartu-labor>
Content-Type: text/plain
Message-Id: <1106939504.18167.364.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 28 Jan 2005 11:11:44 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-28 at 01:33, Meelis Roos wrote:
> eepro100 also drives 82556-based cards. I have a couple of EtherExpress
> PRO/100 Smart cards, Intel identifier is PILA8485, PCI ID is 8086:1228.
> e100 doesn't support them, I'm told eepro100 works (I have not verified
> it myself). I can probably get a card or to for testing with Linux.

See if eepro100 works on your 82556 cards.  I would be surprised if it
does.  If it does, maybe it's not that much trouble to add support to
e100.  Let us know.

-scott

