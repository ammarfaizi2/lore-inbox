Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTFRFdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 01:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265070AbTFRFdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 01:33:04 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:27155 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S263752AbTFRFdC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 01:33:02 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71-mm1 PCMCIA Yenta socket nonfunctional
Date: Wed, 18 Jun 2003 13:16:29 +0800
User-Agent: KMail/1.5.2
References: <200306161343.03663.mflt1@micrologica.com.hk>
In-Reply-To: <200306161343.03663.mflt1@micrologica.com.hk>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306181243.18990.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem fixed in 2.5.72-mm1

Thank you

Regards
Michael

P.S. To: Russel King whose spam filter kills my mail

>On Monday 16 June 2003 19:05, Russell King wrote:
>2003-06-16 11:53:36 H=auth22.inet.co.th [203.150.14.104]
> sender verify fail for <mflt1@micrologica.com.hk>: response to "MAIL FROM:<>"
> from imail.micrologica.com.hk [203.161.231.81] was: 501 bogus mail from
>2003-06-16 11:53:36 H=auth22.inet.co.th [203.150.14.104]
> F=<mflt1@micrologica.com.hk> rejected RCPT <rmk@arm.linux.org.uk>:
> Sender verify failed

>Until your ISP resolves this problem, you will not be able to send me
>email.  Note that I'm copying your ISPs postmaster; neither they will
>be able to contact me until they have resolved the issue.

The IP's are correct and it is not an ISP config problem, 
travel and use local PPP access and local SMTP to send mail.
Fetch incoming mail from HK ISP, so the ISP sending mail 
never matches the ISP receiving the mail.

Regards
Michael


-- 
Powered by linux-2.5.72-mm1, compiled with gcc-2.95-3 because it's rock solid

My current linux related activities in rough order of priority:
- Testing of Swsusp for 2.4
- Learning 2.5 kernel debugging with kgdb - it's in the -mm tree
- Studying 2.5 serial and ide drivers, ACPI, S3

The 2.5 kernel could use your usage. More info on setting it up at
http://www.codemonkey.org.uk/post-halloween-2.5.txt


