Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266585AbUIEMh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266585AbUIEMh3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 08:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266603AbUIEMh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 08:37:28 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:20387 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266585AbUIEMh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 08:37:27 -0400
Message-ID: <413B0872.1090607@yahoo.com.au>
Date: Sun, 05 Sep 2004 22:37:06 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: DaMouse <damouse@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler experiences
References: <1094386464.18114.0.camel@localhost> <1a56ea390409050525583d0438@mail.gmail.com>
In-Reply-To: <1a56ea390409050525583d0438@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DaMouse wrote:

> 
> I personally like staircase, i also used to use nicksched but i prefer
> staircases simple design and structure. Nicksched was pretty fast but
> twiddling around all day with renicing X and now the HT issues are
> annoying and staircase has always worked perfectly for me without
> flipping fifty switches in the cockpit.
> 

The HT issue should be fixed (I hope).

Why did you have to "twiddle around all day with renicing X"? I realise
you're overstating, but you really should be fine with just setting X
to -10 at startup and be done with it.

