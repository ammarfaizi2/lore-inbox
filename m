Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267867AbTAHUW0>; Wed, 8 Jan 2003 15:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267870AbTAHUW0>; Wed, 8 Jan 2003 15:22:26 -0500
Received: from port5.ds1-sby.adsl.cybercity.dk ([212.242.169.198]:23932 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id <S267867AbTAHUWZ>; Wed, 8 Jan 2003 15:22:25 -0500
Date: Wed, 8 Jan 2003 21:31:04 +0100 (CET)
From: Fabio Massimo Di Nitto <fabbione@fabbione.net>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: Andrew McGregor <andrew@indranet.co.nz>,
       Wichert Akkerman <wichert@wiggy.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: [OT] Re: ipv6 stack seems to forget to send ACKs
In-Reply-To: <Pine.LNX.4.44.0301082122190.32244-100000@dns.toxicfilms.tv>
Message-ID: <Pine.LNX.4.51.0301082129180.12716@diapolon.int.fabbione.net>
References: <Pine.LNX.4.44.0301082122190.32244-100000@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Definitly it is somehow unstable. Difficult to find the reason.
Anyway Im sure that there is asimmetric routing between me and
ipv6.lkml.org and I could see pkts coming back. It might not have been the
case for Wichert

Fabio

On Wed, 8 Jan 2003, Maciej Soltysiak wrote:

> > Probably on the server's side it got an ICMP Host Unreachable or two as
> > some router updated its tables, and decided to close the connection.
> Sounds reasonable to me. Could it mean that this router that we are
> talking about is simply slow or overloaded ?
>
> Maciej
>
>
>
