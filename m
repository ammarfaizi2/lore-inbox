Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVB0HhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVB0HhR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 02:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVB0HhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 02:37:17 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:52954 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261362AbVB0HhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 02:37:10 -0500
Date: Sun, 27 Feb 2005 01:35:17 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Invalid module format in Fedora core2
In-reply-to: <3BQcw-7tO-3@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42217835.5020704@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3BPzY-6Vi-33@gated-at.bofh.it> <3BQcw-7tO-3@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> I attached a typical makefile so you can see how complicated
> this new crap is.
> 
> In the meantime, you can just take this and link it with your
> "module.o" to make a "module.ko".

What is all this stuff for? Unless you are doing some pretty bizarre 
things in your module this is far more complex than it needs to be. See:

http://linuxdevices.com/articles/AT4389927951.html

Given your previous posts on this issue I can't help but think you'd be 
better off reading how this can be done simply, rather than whining 
about the "political correctness" of the build process..

