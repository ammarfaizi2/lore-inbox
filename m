Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264943AbTAJUvS>; Fri, 10 Jan 2003 15:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbTAJUvS>; Fri, 10 Jan 2003 15:51:18 -0500
Received: from itg-gw.cr008.cwt.esat.net ([193.120.242.226]:47118 "EHLO
	dunlop.admin.ie.alphyra.com") by vger.kernel.org with ESMTP
	id <S264943AbTAJUvR>; Fri, 10 Jan 2003 15:51:17 -0500
Date: Fri, 10 Jan 2003 20:59:22 +0000 (GMT)
From: Paul Jakma <paulj@alphyra.ie>
X-X-Sender: paulj@dunlop.admin.ie.alphyra.com
To: Fabio Massimo Di Nitto <fabbione@fabbione.net>
cc: Wichert Akkerman <wichert@wiggy.net>,
       Andrew McGregor <andrew@indranet.co.nz>, <netdev@oss.sgi.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: ipv6 stack seems to forget to send ACKs
In-Reply-To: <Pine.LNX.4.51.0301091041390.20149@trider-g7.ext.fabbione.net>
Message-ID: <Pine.LNX.4.44.0301102057220.16084-100000@dunlop.admin.ie.alphyra.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2003, Fabio Massimo Di Nitto wrote:

> hmmmm strange because now I have forced the route to ipv6.lkml.org
> via another ISP (bypassing xs26.net) 

xs26.net posted to the 6bone list not so long that ago that they have 
IPv6 routing stability problems. (they're ditching OSPFv3/ospfd and 
implementing an inhouse IPv6 link-state IGP instead apparently).

> Fabio

regards,
-- 
Paul Jakma	Sys Admin	Alphyra
	paulj@alphyra.ie
Warning: /never/ send email to spam@dishone.st or trap@dishone.st

