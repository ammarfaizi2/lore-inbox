Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270724AbTHQTqS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 15:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270727AbTHQTqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 15:46:18 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:33546 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S270724AbTHQTqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 15:46:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: arjanv@redhat.com, Carlos Velasco <carlosev@newipnet.com>
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Date: Sun, 17 Aug 2003 22:46:12 +0300
X-Mailer: KMail [version 1.4]
Cc: David T Hollis <dhollis@davehollis.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lamont Granquist <lamont@scriptkiddie.org>,
       Bill Davidsen <davidsen@tmr.com>, "David S. Miller" <davem@redhat.com>,
       bloemsaa@xs4all.nl, Marcelo Tosatti <marcelo@conectiva.com.br>,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1030728222606.21100A-100000@gatekeeper.tmr.com> <200308171845560303.00D4B163@192.168.128.16> <1061140404.29559.0.camel@laptop.fenrus.com>
In-Reply-To: <1061140404.29559.0.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200308172246.12835.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 August 2003 20:13, Arjan van de Ven wrote:
> > 1. hidden patch is not in the main linuk kernel stream.... why?
>
> because arpfilter is a more generic way of doing things like this, and
> that IS in the main linux kernel

I am interested in that but last time I googled for it,
neither userspace utils nor any documentation turned up.
I only see some kernel parts of it.
-- 
vda
