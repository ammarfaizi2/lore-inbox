Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUCHQUh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 11:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbUCHQUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 11:20:37 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:26897 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262130AbUCHQUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 11:20:31 -0500
Message-ID: <404CA064.6040108@techsource.com>
Date: Mon, 08 Mar 2004 11:33:40 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: John Bradford <john@grabjohn.com>, root@chaos.analogic.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel 'simulator' and wave-form analysis tool?
References: <4048B36E.8000605@techsource.com> <Pine.LNX.4.53.0403051253220.32349@chaos> <4048CC7F.4070009@techsource.com> <200403061113.i26BDHrs000517@81-2-122-30.bradfords.org.uk> <404A900B.4020105@matchmail.com>
In-Reply-To: <404A900B.4020105@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Fedyk wrote:
> John Bradford wrote:
> 
>>> I must have been unclear.  I was not suggesting adding hardware.  I 
>>> was suggesting that we could run Linux under Bochs, which is a 
>>> software x86 emulator.  Being what it is, hooks can be added to track 
>>> "cpu activity" is it occurs within the emulator.  This is all a 
>>> simulation.  The key idea I was suggesting was to log processor 
>>> activity (of the emulator) and develop a viewer program which would 
>>> help people visualize the activity.
>>
>>
>>
>> Doesn't Valgrind already do most of what you want?
> 
> 
> Can you valgrind a UML process?
> 
> Tim, what will this give you that a stack trace won't?
> 
> 

If your stack gets hosed by a bug, a simulator with a complete history 
of memory writes will help you discover the problem.

I know nothing about Valgrind.

