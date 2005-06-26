Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVFZWxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVFZWxk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 18:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVFZWxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 18:53:40 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:35795 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261352AbVFZWxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 18:53:39 -0400
Date: Sun, 26 Jun 2005 15:53:18 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: bunk@stusta.de, akpm@osdl.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [2.6 patch] drivers/net/hamradio/: cleanups
Message-Id: <20050626155318.7f065d5b.rdunlap@xenotime.net>
In-Reply-To: <42BF2BA9.8060502@pobox.com>
References: <20050502014637.GQ3592@stusta.de>
	<42BF2BA9.8060502@pobox.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jun 2005 18:26:49 -0400 Jeff Garzik wrote:

| Adrian Bunk wrote:
| > This patch contains the following cleanups:
| > - dmascc.c: remove the unused global function dmascc_setup
| 
| Better to use it, then remove it.

                    than ??

---
~Randy
