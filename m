Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbTIYQg4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 12:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbTIYQg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 12:36:56 -0400
Received: from web40902.mail.yahoo.com ([66.218.78.199]:39561 "HELO
	web40902.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261356AbTIYQgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 12:36:55 -0400
Message-ID: <20030925163654.52439.qmail@web40902.mail.yahoo.com>
Date: Thu, 25 Sep 2003 09:36:54 -0700 (PDT)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: 2.6.0-test broke RPM 4.2 on Red Hat 9 in a VERY weird way
To: Paolo Dovera <pdovera@bmind.it>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F730899.7080700@bmind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Dovera,

--- Paolo Dovera <pdovera@bmind.it> wrote:
> Hi, try this:
> 
> export LD_ASSUME_KERNEL=2.4.1
> 
> before run rpm command, this works fine on my RH9

Hmmm. What version of glibc do you have? I have glibc 2.3.2 installed and
I get the same error with LD_ASSUME_KERNEL=2.4.1

I tried LD_ASSUME_KERNEL=2.4.22, since everything is good under 2.4, but that
didn't help either. Another guy said to check the archives, which I did, but
I don't know what to search for.

> 
>         Paolo

Brad

=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
