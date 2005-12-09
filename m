Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbVLILnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVLILnH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 06:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVLILnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 06:43:07 -0500
Received: from hermes.domdv.de ([193.102.202.1]:49929 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S932210AbVLILnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 06:43:05 -0500
Message-ID: <43996DC2.2070605@domdv.de>
Date: Fri, 09 Dec 2005 12:42:58 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Walrond <andrew@walrond.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Machine check exception logging
References: <200512091127.23016.andrew@walrond.org>
In-Reply-To: <200512091127.23016.andrew@walrond.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Walrond wrote:
> I just got three of these in the kernel ring buffer, (simultaneous with 
> something weird happening):
> 
> 	Machine check events logged
> 	Machine check events logged
> 	Machine check events logged
> 
> Logged where?
> 
> I seem to remember there being a daemon that grabs and logs these, but don't 
> remember what it is. Google didn't help.
> 
> Can anyone enlighten me?

ftp://ftp.x86-64.org/pub/linux/tools/mcelog/
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
