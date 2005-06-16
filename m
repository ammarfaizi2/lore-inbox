Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVFQAOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVFQAOo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 20:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVFQAOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 20:14:44 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:54413 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261869AbVFQAOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 20:14:36 -0400
Date: Fri, 17 Jun 2005 01:52:02 +0200 (CEST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@osdl.org>, Alexander Fieroch <fieroch@web.de>,
       bzolnier@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18: nobody
 cared!"
In-Reply-To: <1118960606.24646.58.camel@localhost.localdomain>
Message-ID: <Pine.GSO.4.62.0506170149070.18313@mion.elka.pw.edu.pl>
References: <d6gf8j$jnb$1@sea.gmane.org>  <20050527171613.5f949683.akpm@osdl.org>
 <429A2397.6090609@web.de>  <58cb370e05061401041a67cfa7@mail.gmail.com>
 <42B091EE.4020802@web.de>  <20050615143039.24132251.akpm@osdl.org>
 <1118960606.24646.58.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Jun 2005, Alan Cox wrote:

> On Mer, 2005-06-15 at 22:30, Andrew Morton wrote:
>> Alexander Fieroch <fieroch@web.de> wrote:
>> hm, I thought Alan did a driver for the ITE RAID controller?
>>
>> I had a driver from ITE in the -mm tree for a while.  It still seems to
>> apply and I think it fixes the compile warnings which you saw:
>
> I did but it depends on other fixes to the IDE layer that never got in.
> The -ac tree, Fedora and various other systems support IT8212, the Linus
> kernel does not. Please direct any queries with regards to that to the
> IDE maintainers as I've given up submitting IDE fixes to the base
> kernel.

http://www.ussg.iu.edu/hypermail/linux/kernel/0503.1/0524.html
