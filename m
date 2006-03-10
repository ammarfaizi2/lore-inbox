Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWCJVCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWCJVCx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 16:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWCJVCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 16:02:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5778 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932244AbWCJVCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 16:02:52 -0500
Date: Fri, 10 Mar 2006 13:02:45 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: skge/sk98lin slowdown with 4 Gb memory compared to 2 Gb memory
Message-ID: <20060310130245.4ef31851@localhost.localdomain>
In-Reply-To: <20060310202929.GA7308@amd64.of.nowhere>
References: <20060310202929.GA7308@amd64.of.nowhere>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2006 21:29:29 +0100
jurriaan <thunder7@xs4all.nl> wrote:

> I've just increased the memory on my A8N-SLI Deluxe from 2 Gb to 4 Gb.
> 
> Since then, network connections on my second network card have gone so
> slow as to be almost unusable.
> 
> Two pc's, each connected over a gigabit switch, each get pings at 2 ms
> each packet, where booting with mem=2G immediately fixes that to pings
> at 0.2 or 0.1 second each.
> 
> This happens in kernel 2.6.16-rc5-mm2, with both the sk98lin and the
> skge driver.
> 
> Is this a known phenomenon? I can't be the first A8N-SLI user that
> increases memory to 4 Gb I hope!
> 
> Below is the dmesg output when booting with mem=2G.
> 
> I'd love to know how I can fix this, or how I can help others debug
> this.
> 
> thanks,
> Jurriaan

What is your kernel config?
