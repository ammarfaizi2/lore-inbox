Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbTJRGnD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 02:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbTJRGnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 02:43:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:39307 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261397AbTJRGnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 02:43:01 -0400
Date: Fri, 17 Oct 2003 23:38:16 -0700
From: "David S. Miller" <davem@redhat.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc reliability & performance
Message-Id: <20031017233816.24b20330.davem@redhat.com>
In-Reply-To: <20031018063559.GD16761@alpha.home.local>
References: <1066356438.15931.125.camel@cube>
	<20031017023437.GB28158@work.bitmover.com>
	<01e601c39484$f3fa31c0$890010ac@edumazet>
	<20031017021040.4964309a.davem@redhat.com>
	<20031018063559.GD16761@alpha.home.local>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Oct 2003 08:35:59 +0200
Willy Tarreau <willy@w.ods.org> wrote:

> Hmmm very interesting. And is there an equivalent replacement for
> /proc/net/ip_conntrack ? And if not, what would be needed to implement it ?

I don't know, ask the netfilter developers on the netfilter lists.
:-)
