Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbUCDAgB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 19:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbUCDAgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 19:36:01 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:29024 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261348AbUCDAfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 19:35:45 -0500
Message-ID: <40467C31.2030409@myrealbox.com>
Date: Wed, 03 Mar 2004 16:45:37 -0800
From: walt <wa1ter@myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; NetBSD i386; en-US; rv:1.6) Gecko/20040302
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: udev versus parallel-port Zip drive
References: <40465460.1050600@myrealbox.com> <20040303220135.GA32662@kroah.com>
In-Reply-To: <20040303220135.GA32662@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Mar 03, 2004 at 01:55:44PM -0800, walt wrote:
> 
>> the parallel-port driver for Zip drives (ppa) does not load
>>automatically...

> Here's a little sign to print out for the next time someone tries to
> bring this issue up:
> 
> 	**********************************
> 	* udev does no device discovery! *
> 	**********************************

Okayokayokay!  I admit it was a dumb question.  Now that you point it
out to me with a two-by-four-to-the-forehead I see that udev is a user-
space thing, and devices are a kernel-space thing -- so it was a dumb
question.  Guilty as charged :-(

Innovators are always frustrated with dumb questions from people who
Don't Understand The Problem.  Users are frustrated with innovators
who don't understand the dumb users.  C'est la vie!  Both groups pay
the price for.......whatever it is we pay the price for...

Every dumb question can teach you something about being an innovator.
(The proof is left as an exercise for the reader...)



