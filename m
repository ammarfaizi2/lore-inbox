Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755535AbWKQHZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535AbWKQHZJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 02:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755493AbWKQHZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 02:25:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39836 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1755535AbWKQHZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 02:25:07 -0500
Date: Thu, 16 Nov 2006 23:25:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jarek Poplawski <jarkao2@o2.pl>
cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
       netdev@vger.kernel.org
Subject: Re: [BUG] CREDITS or CREDITS-YOURSELVES
In-Reply-To: <20061117072518.GA1616@ff.dom.local>
Message-ID: <Pine.LNX.4.64.0611162324080.3349@woody.osdl.org>
References: <20061117072518.GA1616@ff.dom.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Nov 2006, Jarek Poplawski wrote:
> 
> With great astonishment I've found none of
> these "networking" names in the CREDITS file:
> Stephen Hemminger, Thomas Graf, Alexey Kuznetsov,
> Andrew Morton, Pedro Roque, Jamal Hadi Salim,
> Herbert Xu etc.

You should basically consider the CREDITS file to be legacy stuff from 
five+ years ago.

For the last five years or so, you can find the real credits in the source 
control history. That didn't use to be true.

		Linus
