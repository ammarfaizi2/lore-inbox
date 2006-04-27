Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbWD0O5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbWD0O5B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 10:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbWD0O5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 10:57:01 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:51408 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S965133AbWD0O5A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 10:57:00 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Avi Kivity <avi@argo.co.il>
Subject: Re: C++ pushback
Date: Thu, 27 Apr 2006 17:56:30 +0300
User-Agent: KMail/1.8.2
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
       Roman Kononov <kononov195-far@yahoo.com>,
       LKML Kernel <linux-kernel@vger.kernel.org>
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <200604271655.48757.vda@ilport.com.ua> <4450D4E9.4050606@argo.co.il>
In-Reply-To: <4450D4E9.4050606@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604271756.30679.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 April 2006 17:27, Avi Kivity wrote:
> > Where do you see goto-heavy code in kernel?
> >
> >   
> 
> [avi@cleopatra linux]$ grep -rw goto . | wc -l
> 37448
> 
> Repeat without 'wc' to get a detailed listing.

In 1999 Dave 'Barc0de' Jones, Paranoid wierdo noize making geek,
wrote this:

http://www.uwsg.iu.edu/hypermail/linux/kernel/9901.2/0939.html

I failed to find a link, but in 2004 Dave Jones, a well-known
kernel hacker, wrote something like "Wow, it's fun to read
my own old mail, how naive I was back then :)"

Feel free to get your hards dirty with kernel development,
and maybe you will say something similar a few years from now.

Or maybe not, and I will be proven wrong.
--
vda
