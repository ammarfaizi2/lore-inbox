Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVBAT0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVBAT0r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 14:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbVBAT0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 14:26:47 -0500
Received: from orb.pobox.com ([207.8.226.5]:26294 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261534AbVBAT0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 14:26:46 -0500
Subject: Re: [ANN] removal of certain net drivers coming soon:
	eepro100,?xircom_tulip_cb, iph5526
From: Scott Feldman <sfeldma@pobox.com>
Reply-To: sfeldma@pobox.com
To: linux-os@analogic.com
Cc: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0502011405530.8039@chaos.analogic.com>
References: <E1CuSUy-00063X-LK@rhn.tartu-labor>
	 <1106939504.18167.364.camel@localhost.localdomain>
	 <Pine.SOC.4.61.0502011444310.26768@math.ut.ee>
	 <1107284234.3366.95.camel@sfeldma-mobl.dsl-verizon.net>
	 <Pine.LNX.4.61.0502011405530.8039@chaos.analogic.com>
Content-Type: text/plain
Message-Id: <1107286101.3366.111.camel@sfeldma-mobl.dsl-verizon.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 01 Feb 2005 11:28:21 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-01 at 11:09, linux-os wrote:
> You just need to load mii first. Both of these drivers are working
> fine on 2.6.10.

Huh?  You have 82556 cards working with eepro100 or e100 on 2.6.10?

Neither driver will work on any card without mii loaded.

-scott

