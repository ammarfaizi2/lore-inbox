Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263975AbTIDH4S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 03:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264776AbTIDH4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 03:56:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:64171 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263975AbTIDH4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 03:56:17 -0400
Date: Thu, 4 Sep 2003 00:46:38 -0700
From: "David S. Miller" <davem@redhat.com>
To: "YOSHIFUJI Hideaki / _$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: jfbeam@bluetronic.net, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       yoshfuji@linux-ipv6.org
Subject: Re: /proc/net/* read drops data
Message-Id: <20030904004638.1d4b001d.davem@redhat.com>
In-Reply-To: <20030903.160733.06230402.yoshfuji@linux-ipv6.org>
References: <Pine.GSO.4.33.0308271658370.7750-100000@sweetums.bluetronic.net>
	<Pine.GSO.4.33.0308271935550.7750-100000@sweetums.bluetronic.net>
	<20030903.160733.06230402.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Sep 2003 16:07:33 +0900 (JST)
YOSHIFUJI Hideaki / _$B5HF#1QL@ <yoshfuji@linux-ipv6.org> wrote:

> D: Fixing a bug that reading /proc/net/{udp,udp6} may drop some data

This fix looks good to me.  Applied.
