Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270367AbTHQQaQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 12:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270365AbTHQQaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 12:30:16 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:53389 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270359AbTHQQaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 12:30:11 -0400
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Carlos Velasco <carlosev@newipnet.com>
Cc: Lamont Granquist <lamont@scriptkiddie.org>,
       Bill Davidsen <davidsen@tmr.com>, "David S. Miller" <davem@redhat.com>,
       bloemsaa@xs4all.nl, Marcelo Tosatti <marcelo@conectiva.com.br>,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200308171759540391.00AA8CAB@192.168.128.16>
References: <Pine.LNX.3.96.1030728222606.21100A-100000@gatekeeper.tmr.com>
	 <20030728213933.F81299@coredump.scriptkiddie.org>
	 <200308171509570955.003E4FEC@192.168.128.16>
	 <200308171516090038.0043F977@192.168.128.16>
	 <1061127715.21885.35.camel@dhcp23.swansea.linux.org.uk>
	 <200308171555280781.0067FB36@192.168.128.16>
	 <1061134091.21886.40.camel@dhcp23.swansea.linux.org.uk>
	 <200308171759540391.00AA8CAB@192.168.128.16>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061137577.21885.50.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 17 Aug 2003 17:26:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-17 at 16:59, Carlos Velasco wrote:
> We are not talking about ARP Replies, we are talking about ARP
> Requests.
> You can see the Richard post here, same issue I reported several weeks
> ago:
> http://marc.theaimsgroup.com/?l=linux-net&m=106094924813337&w=2

You put the foundary devices IP on one of your interfaces ? In which case
your network is misconfigured - go fix it. Two systems are not permitted
to have the same IP address. Linux supports asymettric routing just fine.




