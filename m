Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263944AbUFCLuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263944AbUFCLuN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 07:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbUFCLuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 07:50:13 -0400
Received: from imap.gmx.net ([213.165.64.20]:403 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263944AbUFCLtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 07:49:21 -0400
X-Authenticated: #4512188
Message-ID: <40BF1039.4030403@gmx.de>
Date: Thu, 03 Jun 2004 13:49:13 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040525)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.7-rc1-mm1: libata flooding my log
References: <40B8E8D4.1010905@gmx.de> <40B8EB07.6000700@pobox.com> <40B8F601.2000600@gmx.de> <40BD8B7A.2010901@gmx.de> <40BEB840.8060305@gmx.de> <40BEF10F.1040108@gentoo.org>
In-Reply-To: <40BEF10F.1040108@gentoo.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Prakash K. Cheemplavam wrote:
> 
>> I found another interesting thing: It seems those errors only appear 
>> when I use mozilla thunderbird! Any idea what tb is trying to do to 
>> the hd? As I said earlier kernels didn't report such errors. (Are 
>> those actually errors?)
> 
> 
> I'm having similar problems (posted to linux-ide last week). Its not 
> just thunderbird though, I can easily reproduce this under heavy disk 
> activity (e.g. rsync'ing lots of data with a local server while 
> unpacking/patching a kernel).
> 

I seems 2.6.7-rc2-mm2 fixed the issue. At least since 2h no entry in my 
logs. Well done, Jeff (if it was you :-)).

Prakash
