Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267748AbTAHRfH>; Wed, 8 Jan 2003 12:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267756AbTAHRfG>; Wed, 8 Jan 2003 12:35:06 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:15551 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S267748AbTAHRfG>; Wed, 8 Jan 2003 12:35:06 -0500
Date: Wed, 8 Jan 2003 18:43:45 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: linux-kernel@vger.kernel.org, <netdev@oss.sgi.com>
Subject: Re: ipv6 stack seems to forget to send ACKs
In-Reply-To: <20030108170139.GL22951@wiggy.net>
Message-ID: <Pine.LNX.4.44.0301081838440.26487-100000@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually, I don't follow this. How could any kind of traffic shaping
> result in my client not sending ACKs, which is what the tcpdump
> seems to indicate?
Well, i think i made a mistake, writing about routers dropping the
packets, it's not the case here, you are right.

Maciej


