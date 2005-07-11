Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVGKNW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVGKNW3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 09:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVGKNW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 09:22:29 -0400
Received: from [81.2.110.250] ([81.2.110.250]:27853 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261341AbVGKNWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 09:22:16 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, christoph@lameter.org
In-Reply-To: <20050708145953.0b2d8030.akpm@osdl.org>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <20050708214908.GA31225@taniwha.stupidest.org>
	 <20050708145953.0b2d8030.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1121087925.7407.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 11 Jul 2005 14:18:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-07-08 at 22:59, Andrew Morton wrote:
> Chris Wedgwood <cw@f00f.org> wrote:
> >
> > On Thu, Jun 23, 2005 at 11:28:47AM -0700, Linux Kernel Mailing List wrote:
>           ^^^^^^
> 
> It's been over two weeks and nobody has complained about anything.

Then your mail system is faulty because I did. 1000Hz is good for
multmedia, 
100Hz is good for power management/older boxes, 250Hz is too fast for
some laptop APM to avoid clock slew, too fast for power saving and too
slow for some multimedia weenies.

