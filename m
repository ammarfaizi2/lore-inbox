Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTHSTSK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTHSTQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:16:01 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:18326 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261288AbTHSTGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:06:54 -0400
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: "David S. Miller" <davem@redhat.com>, willy@w.ods.org,
       richard@aspectgroup.co.uk, carlosev@newipnet.com,
       lamont@scriptkiddie.org, davidsen@tmr.com, bloemsaa@xs4all.nl,
       Marcelo Tosatti <marcelo@conectiva.com.br>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030819185219.116fd259.skraw@ithnet.com>
References: <353568DCBAE06148B70767C1B1A93E625EAB58@post.pc.aspectgroup.co.uk>
	 <20030819145403.GA3407@alpha.home.local>
	 <20030819170751.2b92ba2e.skraw@ithnet.com>
	 <20030819085717.56046afd.davem@redhat.com>
	 <20030819185219.116fd259.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061319864.30565.52.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 19 Aug 2003 20:04:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-08-19 at 17:52, Stephan von Krawczynski wrote:
> <quote RFC-985>

Effectively Obsolete.

>       An ARP reply is discarded if the destination IP address does not
>       match the local host address.  An ARP request is discarded if the

The local host address. Singular. Back from the days where addresses
lived by box

