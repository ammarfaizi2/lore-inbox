Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUCGDAE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 22:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbUCGDAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 22:00:03 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:1775 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S261744AbUCGC76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 21:59:58 -0500
Message-ID: <404A900B.4020105@matchmail.com>
Date: Sat, 06 Mar 2004 18:59:23 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: Timothy Miller <miller@techsource.com>, root@chaos.analogic.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel 'simulator' and wave-form analysis tool?
References: <4048B36E.8000605@techsource.com> <Pine.LNX.4.53.0403051253220.32349@chaos> <4048CC7F.4070009@techsource.com> <200403061113.i26BDHrs000517@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200403061113.i26BDHrs000517@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
>>I must have been unclear.  I was not suggesting adding hardware.  I was 
>>suggesting that we could run Linux under Bochs, which is a software x86 
>>emulator.  Being what it is, hooks can be added to track "cpu activity" 
>>is it occurs within the emulator.  This is all a simulation.  The key 
>>idea I was suggesting was to log processor activity (of the emulator) 
>>and develop a viewer program which would help people visualize the activity.
> 
> 
> Doesn't Valgrind already do most of what you want?

Can you valgrind a UML process?

Tim, what will this give you that a stack trace won't?
