Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130407AbRCBLAP>; Fri, 2 Mar 2001 06:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130408AbRCBK6D>; Fri, 2 Mar 2001 05:58:03 -0500
Received: from [62.172.234.2] ([62.172.234.2]:61028 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S130407AbRCBK5t>;
	Fri, 2 Mar 2001 05:57:49 -0500
Date: Fri, 2 Mar 2001 10:57:04 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Ingo Molnar <mingo@elte.hu>
cc: tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>, rml@ufl.edu,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] ps2fix-2.4.2-A0
In-Reply-To: <Pine.LNX.4.30.0103021151090.3299-200000@elte.hu>
Message-ID: <Pine.LNX.4.21.0103021056170.1338-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2001, Ingo Molnar wrote:
> > +       if (c == &misc_list) {
> >
> >   This should be  (c != &misc_list)
> 

oops, I didn't notice -- ignore the patch I sent a minute ago :)

Regards,
Tigran

