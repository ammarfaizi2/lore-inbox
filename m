Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUCOVT5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 16:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbUCOVT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 16:19:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:58343 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262794AbUCOVTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 16:19:45 -0500
Date: Mon, 15 Mar 2004 13:21:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Remove pmdisk from kernel
Message-Id: <20040315132146.24f935c2.akpm@osdl.org>
In-Reply-To: <20040315205752.GG258@elf.ucw.cz>
References: <20040315195440.GA1312@elf.ucw.cz>
	<20040315125357.3330c8c4.akpm@osdl.org>
	<20040315205752.GG258@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> > It would be unfortunate if Pat had more development planned or even
> > underway.  Have we checked?
> 
> Last time I attempted pmdisk removal, he did not react. Lets try one
> more time.

OK.  Best use his current email address..

> I believe that you don't want swsusp2 in 2.6. It has hooks all over
> the place:
> ...
> 109 files changed, 3254 insertions(+), 624 deletions(-)

Ahem.  Agreed.
