Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263181AbSJIXRk>; Wed, 9 Oct 2002 19:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263026AbSJIXQb>; Wed, 9 Oct 2002 19:16:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:44724 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263035AbSJIXPp>;
	Wed, 9 Oct 2002 19:15:45 -0400
Date: Wed, 09 Oct 2002 16:14:14 -0700 (PDT)
Message-Id: <20021009.161414.63434223.davem@redhat.com>
To: dfawcus@cisco.com
Cc: sekiya@sfc.wide.ad.jp, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Fix Prefix Length of Link-local Addresses
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021009234421.J29133@edinburgh.cisco.com>
References: <20021009170018.H29133@edinburgh.cisco.com>
	<uwuor9tg7.wl@sfc.wide.ad.jp>
	<20021009234421.J29133@edinburgh.cisco.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think the change was made because some TAHI test
failed without it, USAGI people is this right?

Most of USAGI changes are of this nature. :-)
