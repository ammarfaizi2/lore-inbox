Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbUL0Kgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbUL0Kgt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 05:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbUL0Kgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 05:36:49 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:65308 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261458AbUL0Keu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 05:34:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=uDKUnVlwqdWD/4wKWtdEfhkBtkHrc/bIDU5L+XQbcz+JeOMiU0X2SlMG4a2DIUz6nMbgfOG9RLI4hWI48v6TquvsaZyt+0QJ8mAw80n6JsSPts9ksOwRjZ2Acmc1M9HvNzxFXEb/d23eZG1OyxetLD3fItvYl6aD5Kc5qXnRP58=
Message-ID: <472a9f230412270234f8eab15@mail.gmail.com>
Date: Mon, 27 Dec 2004 16:04:50 +0530
From: Robin Jose <ackku.jose@gmail.com>
Reply-To: Robin Jose <ackku.jose@gmail.com>
To: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Re: Printk output on console
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041221063222.26890.qmail@web60605.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041221063222.26890.qmail@web60605.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can refer to Rubini's book "Linux Device Drivers 2nd Edition". See
section "How messages gets logged" in Chapter 4, which explains in
detail how to use printk for debugging.

This book is now available online, under Oreilly's open book project
http://www.xml.com/ldd/chapter/book/ch04.html

Thanks,
Robin

On Mon, 20 Dec 2004 22:32:22 -0800 (PST), selvakumar nagendran
<kernelselva@yahoo.com> wrote:
> How can we see the output of printk calls in kernel
> source files in our console. Is there any special
> command or utility for it?
> How to view the output of printk on our console? What
> is the log level to be set for this?
> 
> Thanks,
> selva
> 
> __________________________________
> Do you Yahoo!?
> Take Yahoo! Mail with you! Get it on your mobile phone.
> http://mobile.yahoo.com/maildemo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
