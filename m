Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262737AbVFWVmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbVFWVmE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 17:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbVFWVjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:39:15 -0400
Received: from [12.172.143.34] ([12.172.143.34]:26305 "EHLO
	mail.teleformix.com") by vger.kernel.org with ESMTP id S262816AbVFWVhe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:37:34 -0400
Message-ID: <42BB2B51.5030604@teleformix.com>
Date: Thu, 23 Jun 2005 16:36:17 -0500
From: Dan Oglesby <doglesby@teleformix.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Avuton Olrich <avuton@gmail.com>
CC: Adrian Ulrich <reiser4@blinkenlights.ch>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, ninja@slaphack.com,
       reiser@namesys.com, jgarzik@pobox.com, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
References: <42BAC304.2060802@slaphack.com>	 <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>	 <20050623221222.33074838.reiser4@blinkenlights.ch> <3aa654a405062314296a4ca2ae@mail.gmail.com>
In-Reply-To: <3aa654a405062314296a4ca2ae@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.0.3.2, Antispam-Data: 2005.6.8.46
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_VERSION 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avuton Olrich wrote:
> On 6/23/05, Adrian Ulrich <reiser4@blinkenlights.ch> wrote:
> 
>>From my POV:
>> I've been using Reiser4 for almost everything (Rootfs / External
>> Harddrives) for about ~8 Months without any data loss..
>>
>> Powerloss, unpluging the Disk while writing, full filesystem,
>> heavy use : No problems with reiser4.. It *is* stable.
> 
> 
> *From users who use it* I have heard nothing but love for reiser4.
> It's amazing how quickly people seem to be dismissive about what
> reiser4 has to offer when they more than likely haven't taken it for a
> spin at all. All I hear about is 'we can't let something ugly go into
> the stable kernel' then in the same day I looked into some of the
> config options...
> 
> CONFIG_WDC_ALI15X3:
> *snip*
> This allows for UltraDMA support for WDC drives that ignore CRC
> checking. You are a fool for enabling this option, but there have been
> requests.
> *snip*
> 
> How many have requested that reiser4 make it into the kernel? I'd
> imagine many more then requested this IDE feature. And it's an
> *option*. Please work something out on this.
> 
> avuton
> 

As a user who uses ReiserFS v3, I have nothing but love for ReiserFS.

The speed and reliability are great right now, I'm really looking 
forward to using ReiserFS v4.

--Dan


