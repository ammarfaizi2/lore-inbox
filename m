Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269243AbUIYFqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269243AbUIYFqP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 01:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269246AbUIYFqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 01:46:15 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:61613 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S269243AbUIYFqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 01:46:12 -0400
Date: Fri, 24 Sep 2004 23:45:46 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Problem in loading Module
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <00d801c4a2c2$e7d8b270$6601a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
Content-type: text/plain; reply-type=original; charset=iso-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
References: <fa.jqou8ro.g3cl3k@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What kernel headers are you compiling the module against? They must match 
the actual kernel you are using. If you are using Red Hat kernel 2.4.20-6 
then you must compile against Red Hat 2.4.20-6 kernel headers.


----- Original Message ----- 
From: "Dinesh Ahuja" <mdlinux7@yahoo.co.in>
Newsgroups: fa.linux.kernel
To: <linux-kernel@vger.kernel.org>
Sent: Friday, September 24, 2004 9:28 PM
Subject: Problem in loading Module


>I have recently purchased book "Linux Device Drivers"
> By Alessandro Rubini. I am very keen to learn the
> Kernel Programming and this is my step towards Kernel
> Programming.
>
> I request you to all to guide me whenever I get stuyck
> up in my learning process.
>
> I was facing problem in loading a module example
> hello.o in my Red Hat Linux Kernel 2.4.20-6.
>
> It gives me an error that module has been compiled for
> Kernel 2.4.20 and you are trying to run it on Kernel
> 2.4.20-6 [which is a kernel comes with Red Hat 9.0]
>
> Please guide me over this issue so that I can proceed
> further in learning process.
>
> Thanks & Regards
> Dinesh
>
>
>
> ________________________________________________________________________
> Yahoo! India Matrimony: Find your life partner online
> Go to: http://yahoo.shaadi.com/india-matrimony
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/ 

