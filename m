Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbUDDJRi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 05:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbUDDJRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 05:17:38 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:10374 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262274AbUDDJRh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 05:17:37 -0400
Date: Sun, 4 Apr 2004 11:15:13 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Malvineous <malvineous@optushome.com.au>
Cc: Manfred Spraul <manfred@colorfullife.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, a.nielsen@optushome.com.au
Subject: Re: [PATCH] Fix kernel lockup in RTL-8169 gigabit ethernet driver
Message-ID: <20040404111513.A3165@electric-eye.fr.zoreil.com>
References: <406EA054.2020401@colorfullife.com> <20040404105558.2bffd4f0.malvineous@optushome.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040404105558.2bffd4f0.malvineous@optushome.com.au>; from malvineous@optushome.com.au on Sun, Apr 04, 2004 at 10:55:58AM +1000
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Malvineous <malvineous@optushome.com.au> :
[...]
> I did add a 'printk' line in to see what the variables were just to make
> sure this was the location of the bug, and as I expected none of
> the values changed at all.

Can you send the unpatched r8169.o module ?

Thanks in advance.

--
Ueimor

