Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVGKQ4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVGKQ4b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbVGKQ4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:56:25 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:9412 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262141AbVGKQ4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:56:13 -0400
Date: Mon, 11 Jul 2005 09:55:51 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add kerneldoc reference to CodingStyle
Message-Id: <20050711095551.4b40ba54.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.58.0507110931290.8748@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0507110931290.8748@sbz-30.cs.Helsinki.FI>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2005 09:32:00 +0300 (EEST) Pekka J Enberg wrote:

| Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
| ---
| 
|  CodingStyle |    3 +++
|  1 files changed, 3 insertions(+)
| 
| Index: 2.6/Documentation/CodingStyle
| ===================================================================
| --- 2.6.orig/Documentation/CodingStyle
| +++ 2.6/Documentation/CodingStyle
| @@ -236,6 +236,9 @@ ugly), but try to avoid excess.  Instead
|  of the function, telling people what it does, and possibly WHY it does
|  it.
|  
| +When commenting the kernel API functions, please use the kerneldoc format.
| +See the file scripts/kernel-doc for details.
   See the files Documentation/kernel-doc-nano-HOWTO.txt and scripts/kernel-doc
   for details.
| +
|  
|  		Chapter 8: You've made a mess of it
|  
| -


---
~Randy
