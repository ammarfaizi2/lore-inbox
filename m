Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTEBVzC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 17:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263186AbTEBVzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 17:55:02 -0400
Received: from [12.47.58.20] ([12.47.58.20]:16044 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263185AbTEBVzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 17:55:01 -0400
Date: Fri, 2 May 2003 15:04:02 -0700
From: Andrew Morton <akpm@digeo.com>
To: Kimmo Sundqvist <rabbit80@mbnet.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-mm4 and 3c900 is a horror
Message-Id: <20030502150402.26c4f3b3.akpm@digeo.com>
In-Reply-To: <200305022102.01420.rabbit80@mbnet.fi>
References: <200305022102.01420.rabbit80@mbnet.fi>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 May 2003 22:07:21.0259 (UTC) FILETIME=[340AB7B0:01C310F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kimmo Sundqvist <rabbit80@mbnet.fi> wrote:
>
> 2.5.68-mm4, but something less extreme from now on
> 
> There are many kinds of these... the trouble seems to be with the Ethernet 
> card, a 3com 3c900.
> 
> May  2 20:34:10 minjami kernel: irq 19: nobody cared!

Very odd.  How often does this happen?  Once a minute?  Once a second? 
Every packet?

