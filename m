Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965115AbWFANZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbWFANZx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 09:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbWFANZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 09:25:53 -0400
Received: from [195.23.16.24] ([195.23.16.24]:17817 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S965115AbWFANZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 09:25:52 -0400
Message-ID: <447EEADC.4050306@grupopie.com>
Date: Thu, 01 Jun 2006 14:25:48 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: "Abu M. Muttalib" <abum@aftek.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Page Allocation Failure, Why?? Bug in kernel??
References: <BKEKJNIHLJDCFGDBOHGMAEHNCNAA.abum@aftek.com>
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMAEHNCNAA.abum@aftek.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abu M. Muttalib wrote:
> Hi,

Hi,

> I tried to run an application, try-sound.c. In the course of the run of the
> application I repeatedly got page allocation failure, despite the fact that
> enough pages are free. Why this is so, is it a bug in mm subsystem of Linux
> kernel 2.6.13?
> 
> Any pointer to help understand this behavior will be highly appreciated.

If you're expecting kernel developers to unpack your text file and read 
through 40555(!!!) lines of text to find out what's wrong...

Please try to explain your problem better with some before / after 
comparisons that fit nicely into an email and point out specifically 
where you think it went wrong. Also describe what you're trying to do 
and what kind of hardware you're using.

For more detailed information on how to report kernel bugs, please read 
the file REPORTING-BUGS in the main kernel source directory.

Please don't see this as a "we don't care" message. If the kernel has 
indeed a bug we very much do care! We just can't go through thousands of 
lines of text to try to understand what the problem is... :(

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?
