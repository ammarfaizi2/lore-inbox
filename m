Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131527AbRAQVoH>; Wed, 17 Jan 2001 16:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132389AbRAQVn6>; Wed, 17 Jan 2001 16:43:58 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:39236 "EHLO
	amsmta06-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S131527AbRAQVnt>; Wed, 17 Jan 2001 16:43:49 -0500
Date: Wed, 17 Jan 2001 23:50:43 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Rajiv Majumdar <rmajumda@tcg-software.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: detecting bounced mails
In-Reply-To: <652569D7.003CB690.00@gemini.tcg-software.com>
Message-ID: <Pine.LNX.4.21.0101172349500.26160-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2001, Rajiv Majumdar wrote:

> 
> 
> Sorry..the topic does not fit here. But wanted to know, how can we check
> validity of an email id "in advance"

You can't. Only think you can check is a valid domain that will in theory
accept mail, no way to check if it really dilivers.

> so that we can skip "bounce".
> 
> Thanks!
> Rajiv


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
