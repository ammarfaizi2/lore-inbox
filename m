Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbWARCbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWARCbM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 21:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWARCbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 21:31:11 -0500
Received: from stinky.trash.net ([213.144.137.162]:29586 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S932533AbWARCbK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 21:31:10 -0500
Message-ID: <43CDA834.3070301@trash.net>
Date: Wed, 18 Jan 2006 03:30:12 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, Harald Welte <laforge@netfilter.org>,
       coreteam@netfilter.org, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [netfilter-core] [patch 2.6.15-mm4] sem2mutex: netfilter x_table.c
References: <20060114143042.GA17675@elte.hu>
In-Reply-To: <20060114143042.GA17675@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> From: Ingo Molnar <mingo@elte.hu>
> 
> semaphore to mutex conversion.
> 
> the conversion was generated via scripts, and the result was validated
> automatically via a script as well.

I haven't followed all the mutex patches, is this intended
for mainline or for -mm?

