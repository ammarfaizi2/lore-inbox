Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275422AbTHIVwY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 17:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275421AbTHIVwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 17:52:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33961 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S275417AbTHIVwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 17:52:21 -0400
Date: Sat, 9 Aug 2003 14:45:30 -0700
From: "David S. Miller" <davem@redhat.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: ilya@theIlya.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill EXPORT_NO_SYMBOLS from meth.c
Message-Id: <20030809144530.5e515af2.davem@redhat.com>
In-Reply-To: <20030809191451.GJ16091@fs.tum.de>
References: <20030809191451.GJ16091@fs.tum.de>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Aug 2003 21:14:52 +0200
Adrian Bunk <bunk@fs.tum.de> wrote:

> The patch below kills an occurence of the obsolete EXPORT_NO_SYMBOLS 
> from drivers/net/meth.c in 2.6.0-test3.

Patch applied, thanks Adrian.
