Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270352AbTGWOsY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 10:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270367AbTGWOsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 10:48:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59538 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S270352AbTGWOsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 10:48:22 -0400
Date: Wed, 23 Jul 2003 08:01:04 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Carlos Velasco" <carlosev@newipnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: ARP with wrong ip?
Message-Id: <20030723080104.67186fd4.davem@redhat.com>
In-Reply-To: <200307231636280719.1CC18139@192.168.128.16>
References: <200307182357260552.063FA10C@192.168.128.16>
	<200307231541180759.1C8EFFB1@192.168.128.16>
	<20030723070026.610ac63e.davem@redhat.com>
	<200307231636280719.1CC18139@192.168.128.16>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 16:36:28 +0200
"Carlos Velasco" <carlosev@newipnet.com> wrote:

> Also, I have searched into ipv4/README:
> Maintainers and developers for networking code sections

This file has been deleted because it is %100 inaccurate.
It is not the place to look for maintainership.

Oddly enough, proper place for "MAINTAINER" information is in file
"linux/MAINTAINERS".

In that file you will find this entry:

NETWORKING [IPv4/IPv6]
P:      David S. Miller
M:      davem@redhat.com
P:      Alexey Kuznetsov
M:      kuznet@ms2.inr.ac.ru
P:      Pekka Savola (ipv6)
M:      pekkas@netcore.fi
P:      James Morris
M:      jmorris@intercode.com.au
P:      Hideaki YOSHIFUJI
M:      yoshfuji@linux-ipv6.org
L:      netdev@oss.sgi.com
S:      Maintained

Which mentions netdev@oss.sgi.com as the mailing list for
discussions like this one.

linux-net@vger.kernel.org is for mainly user-level configuration
discussions.
