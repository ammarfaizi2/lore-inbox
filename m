Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbUJYIZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbUJYIZL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 04:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbUJYITX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 04:19:23 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:22699 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261710AbUJYHjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:39:31 -0400
Message-ID: <417CADAC.5060608@yahoo.com.au>
Date: Mon, 25 Oct 2004 17:39:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
CC: linux-kernel@vger.kernel.org, Paulo Marques <pmarques@grupopie.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] reduce top(1) CPU usage by an order of magnitude
References: <200410251020.01932.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200410251020.01932.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> Patch is not mine, Paulo Marques <pmarques@grupopie.com>
> wrote it.
> 
> I tested in on 2.6.9-rc2. top(1) CPU usage went from ~40% to ~4%
> (yes, test box is a rather old piece of junk).
> 
> The patch applies cleanly to 2.6.9.

Patch is already merged.

