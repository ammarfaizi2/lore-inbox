Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262506AbTAIKYI>; Thu, 9 Jan 2003 05:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262528AbTAIKYI>; Thu, 9 Jan 2003 05:24:08 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:30377 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S262506AbTAIKYI>; Thu, 9 Jan 2003 05:24:08 -0500
Date: Thu, 9 Jan 2003 11:32:47 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: Andrew McGregor <andrew@indranet.co.nz>,
       Fabio Massimo Di Nitto <fabbione@fabbione.net>, <netdev@oss.sgi.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: ipv6 stack seems to forget to send ACKs
In-Reply-To: <20030108224339.GO22951@wiggy.net>
Message-ID: <Pine.LNX.4.44.0301091131370.29527-100000@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The fact that this problem does not seem to occur when using a window
> XP client seems to contradict the suggestions that it may be a router
> problem.
What other linux clients support streaming on ip6 ? patched mpg123 maybe?
What XP client are you using ?

Maybe it is a client issue, you say the client stops sending ACKs, maybe
the client code is buggy.

> Wichert.
Maciej.


