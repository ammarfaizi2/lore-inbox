Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263225AbTCTHkY>; Thu, 20 Mar 2003 02:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263224AbTCTHkY>; Thu, 20 Mar 2003 02:40:24 -0500
Received: from [196.41.29.142] ([196.41.29.142]:1527 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id <S263225AbTCTHkX>; Thu, 20 Mar 2003 02:40:23 -0500
Subject: Re: [PATCH 2.5] PCI quirk for SMBus bridge on Asus P4 boards
From: Martin Schlemmer <azarah@gentoo.org>
To: Dominik Brodowski <linux@brodo.de>
Cc: alan@lxorguk.ukuu.org.uk, KML <linux-kernel@vger.kernel.org>,
       sensors@stimpy.netroedge.com
In-Reply-To: <20030319211837.GA23651@brodo.de>
References: <20030319211837.GA23651@brodo.de>
Content-Type: text/plain
Organization: 
Message-Id: <1048146514.12350.43.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2- 
Date: 20 Mar 2003 09:48:35 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-19 at 23:18, Dominik Brodowski wrote:
> Asus hides the SMBus PCI bridge within the ICH2 or ICH4 southbridge on
> Asus P4B/P4PE mainboards. The attached patch adds a quirk to re-enable the
> SMBus PCI bridge for P4B533 and P4PE mainboards.
> 

The ASUS P4T533-C J(850E Chipset) does that as well .... think you might
tweak the patch for this board ?  I can test if you can ....


Regards,

-- 
Martin Schlemmer


