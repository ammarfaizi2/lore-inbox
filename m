Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVEQDBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVEQDBW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 23:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVEQDBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 23:01:22 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:13696 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261264AbVEQDBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 23:01:20 -0400
Date: Mon, 16 May 2005 20:01:13 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Christoph Lameter <christoph@lameter.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, shai@scalex86.org, ak@suse.de,
       torvalds@osdl.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
Message-Id: <20050516200113.63f1dfcd.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.62.0505161954470.25647@graphe.net>
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw>
	<20050516150907.6fde04d3.akpm@osdl.org>
	<Pine.LNX.4.62.0505161934220.25315@graphe.net>
	<20050516194651.1debabfd.rdunlap@xenotime.net>
	<Pine.LNX.4.62.0505161954470.25647@graphe.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005 19:55:42 -0700 (PDT) Christoph Lameter wrote:

| On Mon, 16 May 2005, randy_dunlap wrote:
| 
| > |  endmenu
| > 
| > How about using choice / endchoice to that an improper HZ value
| > cannot be entered at all?  (instead of using range M N)
| 
| That would not allow to set the value of CONFIG_HZ to a numeric value.
| I would have CONFIG_HZ_100 CONFIG_HZ_250 etc. Gets a bit complicated
| to handle.

Ack, I see.

Thanks for explaining.

---
~Randy
