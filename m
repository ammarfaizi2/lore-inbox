Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbTKETep (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 14:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbTKETep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 14:34:45 -0500
Received: from pizda.ninka.net ([216.101.162.242]:63129 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263126AbTKETen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 14:34:43 -0500
Date: Wed, 5 Nov 2003 11:29:33 -0800
From: "David S. Miller" <davem@redhat.com>
To: "YOSHIFUJI Hideaki / _$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: 2.6.0-test9: Kernel OOPS in /sbin/nameif
Message-Id: <20031105112933.6d93a632.davem@redhat.com>
In-Reply-To: <20031106.023237.110009516.yoshfuji@linux-ipv6.org>
References: <200311051703.hA5H38nQ007123@turing-police.cc.vt.edu>
	<20031106.023237.110009516.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Nov 2003 02:32:37 +0900 (JST)
YOSHIFUJI Hideaki / _$B5HF#1QL@ <yoshfuji@linux-ipv6.org> wrote:

> Please try this.
> 
> ===== net/ipv6/addrconf.c 1.74 vs edited =====
> --- 1.74/net/ipv6/addrconf.c	Tue Oct 28 20:10:47 2003
> +++ edited/net/ipv6/addrconf.c	Thu Nov  6 02:30:03 2003

Applied, thank you Yoshfuji.
