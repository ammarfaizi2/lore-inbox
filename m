Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267871AbTAHUSU>; Wed, 8 Jan 2003 15:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267851AbTAHUSU>; Wed, 8 Jan 2003 15:18:20 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:26576 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S267871AbTAHUST>; Wed, 8 Jan 2003 15:18:19 -0500
Date: Wed, 8 Jan 2003 21:27:02 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Andrew McGregor <andrew@indranet.co.nz>
Cc: Fabio Massimo Di Nitto <fabbione@fabbione.net>,
       Wichert Akkerman <wichert@wiggy.net>, <netdev@oss.sgi.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: ipv6 stack seems to forget to send ACKs
In-Reply-To: <78180000.1042055993@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0301082122190.32244-100000@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Probably on the server's side it got an ICMP Host Unreachable or two as
> some router updated its tables, and decided to close the connection.
Sounds reasonable to me. Could it mean that this router that we are
talking about is simply slow or overloaded ?

Maciej


