Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315529AbSGNEGz>; Sun, 14 Jul 2002 00:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315607AbSGNEGy>; Sun, 14 Jul 2002 00:06:54 -0400
Received: from pizda.ninka.net ([216.101.162.242]:39095 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315529AbSGNEGy>;
	Sun, 14 Jul 2002 00:06:54 -0400
Date: Sat, 13 Jul 2002 20:59:30 -0700 (PDT)
Message-Id: <20020713.205930.101495830.davem@redhat.com>
To: davidsen@tmr.com
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [BUG?] unwanted proxy arp in 2.4.19-pre10
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.3.96.1020713230703.16934B-100000@gatekeeper.tmr.com>
References: <1026584920.13885.29.camel@irongate.swansea.linux.org.uk>
	<Pine.LNX.3.96.1020713230703.16934B-100000@gatekeeper.tmr.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You have to use specific source-routing settings in conjuntion with
enabling arp_filter in order for arp_filter to have any effect.

This is a FAQ.
