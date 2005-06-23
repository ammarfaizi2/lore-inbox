Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbVFWTN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbVFWTN4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 15:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbVFWTIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 15:08:00 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:27576 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262687AbVFWTHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 15:07:02 -0400
Date: Thu, 23 Jun 2005 12:06:47 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: piotrowskim@trex.wsi.edu.pl, linux-kernel@vger.kernel.org
Subject: Re: Script to help users to report a BUG
Message-Id: <20050623120647.2a5783d1.rdunlap@xenotime.net>
In-Reply-To: <9a87484905062311246243774e@mail.gmail.com>
References: <4d8e3fd30506191332264eb4ae@mail.gmail.com>
	<20050622120848.717e2fe2.rdunlap@xenotime.net>
	<42B9CFA1.6030702@trex.wsi.edu.pl>
	<20050622174744.75a07a7f.rdunlap@xenotime.net>
	<9a87484905062311246243774e@mail.gmail.com>
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

On Thu, 23 Jun 2005 20:24:15 +0200 Jesper Juhl wrote:

| On 6/23/05, randy_dunlap <rdunlap@xenotime.net> wrote:
| > 
| > 6.  Use $EDITOR instead of vim if it is defined (set).
| > 
| Wouldn't the very best be to try and find the editor to use in the
| following order?  :
| 
| A) the value of $EDITOR (if set)
| B) the value of $VISUAL (if set)
| C) the first editor in a hardcoded list that exists and is executable
| (a list could contain for example; vim, vi, elvis, joe, jove, nano,
| pico, mcedit, emacs )...

Yes, that sounds better to me.

---
~Randy
