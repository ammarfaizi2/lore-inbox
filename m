Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbTD3W6V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 18:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbTD3W6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 18:58:21 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:27073 "EHLO
	alpha.stev.org") by vger.kernel.org with ESMTP id S262493AbTD3W6U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 18:58:20 -0400
Subject: Re: 3c59x support
From: James Stevenson <james@stev.org>
To: borkdude@cs.utwente.nl
Cc: linux-kernel@vger.kernel.org, andrewm@uow.edu.au, netdev@oss.sgi.com
In-Reply-To: <200304290202.02811.borkdude@cs.utwente.nl>
References: <200304290202.02811.borkdude@cs.utwente.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 May 2003 00:17:21 +0100
Message-Id: <1051744645.2308.11.camel@god.stev.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

i also had problems with the card in some 2.4.x releases
but it seems to work for me on a 2.4.20 kernel.

3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0a.0: 3Com PCI 3c905C Tornado at 0xec00. Vers LK1.1.16

i do still have problems with a card in another machine when rebooting
from windows into linux it fails to init properly.
But since the machine boots from nfs i have not been bothered to
dump the info from this.


On Tue, 2003-04-29 at 01:02, Michiel Borkent wrote:
> Hello,
> I am trying to make a 2.4.20 kernel with 3c59x support.
> My card is a:
> 
> 3Com 3c900 Cyclone 10Mbps TPO 
> 
> card and it only works with the 3c59x-scyld module, I found with Debian Woody 
> with a linux v2.2 kernel.
> 
> It does NOT work with the normal 3c59x module and as I am trying to make a 
> 2.4.20 kernel, it still doesn't work. I chose support for "Vortex/Boomerang" 
> and normally my card would be supported I think.
> 
> Can someone help me with this?
> 
> Greetings,
> Michiel Borkent
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



