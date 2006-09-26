Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWIZSXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWIZSXx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 14:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWIZSXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 14:23:53 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:9100 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932404AbWIZSXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 14:23:52 -0400
Message-ID: <45197034.1040908@pobox.com>
Date: Tue, 26 Sep 2006 14:23:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Stas Sergeev <stsp@aknet.ru>
CC: Linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-mm1 (Oops in sata_nv)
References: <45196ED2.90405@aknet.ru>
In-Reply-To: <45196ED2.90405@aknet.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev wrote:
> Hi.
> 
> Andrew Morton wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm1/ 
>>
> Not that I've been able to run -mm for the
> last few months, but now at least I've got
> an oops, which is better than nothing. :)
> Attached. Any guesses, or should I start the
> binary-search?

The fix is probably the one just committed upstream...

	Jeff



