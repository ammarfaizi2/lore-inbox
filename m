Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266253AbTGFRiE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 13:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266257AbTGFRiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 13:38:04 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26531
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S266253AbTGFRiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 13:38:03 -0400
Subject: Re: 2.4.21 ServerWorks DMA Bugs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Tomas Szepe <szepe@pinerecords.com>, Ryan Mack <lists@mackman.net>,
       Markus Plail <linux-kernel@gitteundmarkus.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030706184242.A20851@ucw.cz>
References: <Pine.LNX.4.53.0307042325430.3837@mackman.net>
	 <87fzllh21i.fsf@gitteundmarkus.de>
	 <Pine.LNX.4.53.0307050956060.2029@mackman.net>
	 <1057477237.700.6.camel@dhcp22.swansea.linux.org.uk>
	 <20030706090656.GA4739@louise.pinerecords.com>
	 <1057482631.705.15.camel@dhcp22.swansea.linux.org.uk>
	 <20030706111015.GA303@louise.pinerecords.com>
	 <1057491491.1032.0.camel@dhcp22.swansea.linux.org.uk>
	 <20030706184242.A20851@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057513783.1032.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Jul 2003 18:49:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-06 at 17:42, Vojtech Pavlik wrote:
> IMO the driver should do that in that case. There are way too many
> broken BIOSes to make following what they decided to set up worthwhile.

It is required in the serverworks case. In the Compaq case there is also
a pending fix to do the basic same stuff for OSB4.


