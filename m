Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUCMNMj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 08:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbUCMNMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 08:12:39 -0500
Received: from web86302.mail.ukl.yahoo.com ([217.12.12.61]:896 "HELO
	web86302.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263088AbUCMNMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 08:12:37 -0500
Message-ID: <20040313131236.37005.qmail@web86302.mail.ukl.yahoo.com>
Date: Sat, 13 Mar 2004 13:12:36 +0000 (GMT)
From: =?iso-8859-1?q?SUBODH=20SHRIVASTAVA?= <subodh@btopenworld.com>
Subject: Re: 2.6.4-mm1
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040312155540.724dcc56.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Andrew Morton <akpm@osdl.org> wrote: > Subodh
Shrivastava <subodh@btopenworld.com> wrote:
> >
> > I am able to boot vanilla kernel without the
> following option enabled
> > 
> > CONFIG_PCI_USE_VECTOR
> > 
> > If i don't enable the above mentioned option
> 2.6.4-mm1 won't boot on my 
> 
>        ^^^^^ "do", I assume?

Let me try to put it correct again.

2.6.4 boots fine with the following option set as
CONFIG_PCI_USE_VECTOR=N

2.6.4-mm1 will not boot with the following option set
as.
CONFIG_PCI_USE_VECTOR=N
2.6.4-mm1 will boot with the following option set as
CONFIG_PCI_USE_VECTOR=Y

> 
> > Laptop
> 
> Is this unique to 2.6.4-mm1 or does 2.6.4 do the
> same thing? 
Yes its unique to 2.6.4-mm1.

Subodh
