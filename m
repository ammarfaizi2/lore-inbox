Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbUJYUKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbUJYUKf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 16:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbUJYUJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 16:09:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51936 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261308AbUJYUEX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 16:04:23 -0400
Message-ID: <417D5C31.8000806@pobox.com>
Date: Mon, 25 Oct 2004 16:04:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: Linus Torvalds <torvalds@osdl.org>, Joe Perches <joe@perches.com>,
       Larry McVoy <lm@work.bitmover.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
References: <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org> <20041023161253.GA17537@work.bitmover.com> <4d8e3fd304102403241e5a69a5@mail.gmail.com> <20041024144448.GA575@work.bitmover.com> <4d8e3fd304102409443c01c5da@mail.gmail.com> <20041024233214.GA9772@work.bitmover.com> <20041025114641.GU14325@dualathlon.random> <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random> <Pine.LNX.4.58.0410250812300.3016@ppc970.osdl.org> <20041025154318.GA14325@dualathlon.random>
In-Reply-To: <20041025154318.GA14325@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Mon, Oct 25, 2004 at 08:14:25AM -0700, Linus Torvalds wrote:
> 
>>Your point is pointless. No such distributed revision control system 
>>exists. And without BK, the people who have worked on them wouldn't 
> 
> 
> arch exists and it's exactly as distributed as BK.


It doesn't scale or merge as well as BK though.

I've told Larry that, if both BK and <open source tool> were completely 
equal in terms of function, I'd use the open source tool.  Neither arch 
(scalability) nor subversion (scalability + stability) are there yet.

	Jeff


