Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbTKNTI5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 14:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbTKNTI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 14:08:57 -0500
Received: from calisto.ae.poznan.pl ([150.254.37.3]:16007 "EHLO
	calisto.ae.poznan.pl") by vger.kernel.org with ESMTP
	id S262356AbTKNTI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 14:08:56 -0500
Date: Fri, 14 Nov 2003 20:08:33 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Harald Welte <laforge@gnumonks.org>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: [2.6] Nonsense-messages from iptables + co.
In-Reply-To: <20031114151004.GE2395@obroa-skai.de.gnumonks.org>
Message-ID: <Pine.LNX.4.51.0311142004510.10963@dns.toxicfilms.tv>
References: <20031114132054.GA646@merlin.emma.line.org>
 <20031114151004.GE2395@obroa-skai.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Rating: 0 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is IMHO a MUST-FIX before 2.6.0.
>
> It is even in 2.4.x, where it could have been fixed throughout the last
> couple of years.  Nobody else has yet complained.
Well, I have noticed an increased amount of these 2 weeks ago, and I
belive it was Patrick McHardy, who found a bug that could cause these
to show, when no root process was creating any invalid packets.

AFAIK, it has been fixed in 2.6.0-test9-bk16 or around that.

The message stays though :-)

Maciej.

