Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266139AbUGOIwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbUGOIwz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 04:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266146AbUGOIwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 04:52:55 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:28890 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S266139AbUGOIwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 04:52:54 -0400
Date: Thu, 15 Jul 2004 11:08:02 +0200
From: Vincent Touquet <vincent.touquet@pandora.be>
To: John Goerzen <jgoerzen@complete.org>, linux-kernel@vger.kernel.org,
       linux-thinkpad@linux-thinkpad.org
Subject: Re: [ltp] Re: ACPI Hibernate and Suspend Strange behavior 2.6.7/-mm1
Message-ID: <20040715090802.GA16637@serv.mine.dnsalias.org>
Reply-To: vincent.touquet@pandora.be
References: <A6974D8E5F98D511BB910002A50A6647615FEF48@hdsmsx403.hd.intel.com> <1089054013.15671.48.camel@dhcppc4> <pan.2004.07.06.14.14.47.995955@physik.hu-berlin.de> <slrncfb55n.dkv.jgoerzen@christoph.complete.org> <20040714202700.GF22472@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714202700.GF22472@khan.acc.umu.se>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 10:27:00PM +0200, David Weinehall wrote:
>Does poweroff work for you?  At least my T40 has problems shutting off
>properly when using 2.6 + ACPI.  A bit annoying; I have to keep the
>powerkey pressed for a few seconds for it to turn off.

Same here.
Would booting with nolapic work ?
Haven't tried it yet...

v
