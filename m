Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267241AbRGTTV1>; Fri, 20 Jul 2001 15:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267244AbRGTTVR>; Fri, 20 Jul 2001 15:21:17 -0400
Received: from mail.zmailer.org ([194.252.70.162]:34566 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S267241AbRGTTVI>;
	Fri, 20 Jul 2001 15:21:08 -0400
Date: Fri, 20 Jul 2001 22:21:07 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Dipak Biswas <dipak@monmouth.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Please suggest me
Message-ID: <20010720222107.A5559@mea-ext.zmailer.org>
In-Reply-To: <3B5874AC.43D2E698@monmouth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B5874AC.43D2E698@monmouth.com>; from dipak@monmouth.com on Fri, Jul 20, 2001 at 02:13:00PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 20, 2001 at 02:13:00PM -0400, Dipak Biswas wrote:
> Hi All,
>     I'm quite new to linux world. I've a very awkard question for you.
> That is: I'm writting an user process, where I need all outgoing
> IP packets to be blocked and captured. First, is it really possible? If
> yes, how? I don't want to make any kernel source code changes. A wild
> guess: by configuration changes, is it possible to make IP process write
> on to a particular FD which I can read when I require?

	Look at how tools like  tcpdump  and  etherreal  do it.
	It has been done over and over again -- in userspace tool.

> Thanks,
> dipak

/Matti Aarnio
