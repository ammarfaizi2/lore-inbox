Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVLBQYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVLBQYb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 11:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVLBQYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 11:24:31 -0500
Received: from mail.tmr.com ([64.65.253.246]:18841 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1750797AbVLBQYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 11:24:31 -0500
Message-ID: <4390782E.3020700@tmr.com>
Date: Fri, 02 Dec 2005 11:37:02 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Too many disks in system? (RAID5)
References: <20051128222558.GN2529@mail.muni.cz> <20051128223623.GA3803@csclub.uwaterloo.ca> <438CAA7B.2030500@tmr.com> <20051129220121.GY3801@csclub.uwaterloo.ca> <20051130153451.GA4538@irc.pl> <20051130154732.GC3803@csclub.uwaterloo.ca>
In-Reply-To: <20051130154732.GC3803@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> On Wed, Nov 30, 2005 at 04:34:51PM +0100, Tomasz Torcz wrote:
> 
>> udev requirements tend to be overstated. I run 2.6.15-rc3 with udev-064
>>and everything works fine.
> 
> 
> Perhaps udev is just overrated. :)  Maybe if I used usb devices a lot I
> would find it useful or something.

Actually, keeping /dev clean is a reason. I haven't added it to existing 
machines with distros no uning udev, I use it on machines which come 
with it.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
