Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbVJRXgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVJRXgO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 19:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVJRXgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 19:36:14 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:31762 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S932087AbVJRXgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 19:36:14 -0400
Message-ID: <4355969C.6060803@superbug.demon.co.uk>
Date: Wed, 19 Oct 2005 01:43:08 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: When is OSS going to go?
References: <43553887.4020305@comcast.net>
In-Reply-To: <43553887.4020305@comcast.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:
> The Open Sound System has been depricated. . . since. . . when the heck?
>  2.4?  Is it ever going to drop off?  Are there a few cards in OSS that
> don't work right in ASLA?
> 

There are still a few cards, hardly any in fact, that work better in OSS 
so why bother removing it? Maybe we should add an extra config option in 
the kernel.
1) Show/Hide depreciated (add this one)
2) Show/Hide experimental (we already have this one)
