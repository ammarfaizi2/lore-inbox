Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbUKIMsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbUKIMsP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 07:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbUKIMsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 07:48:15 -0500
Received: from alog0093.analogic.com ([208.224.220.108]:16000 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261532AbUKIMsM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 07:48:12 -0500
Date: Tue, 9 Nov 2004 07:46:31 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Valdis.Kletnieks@vt.edu
cc: Colin Leroy <colin.lkml@colino.net>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: insmod module-loading errors, Linux-2.6.9 
In-Reply-To: <200411090000.iA900Obi004485@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.61.0411090745160.11563@chaos.analogic.com>
References: <200411090000.iA900Obi004485@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2004 Valdis.Kletnieks@vt.edu wrote:

> On Mon, 08 Nov 2004 12:52:18 EST, linux-os said:
>
>> There are certainly work-arounds for problems that shouldn't
>> exist at all. So, every time I do something to a kernel, I
>> have to change whatever the EXTRAVERSION field is?  Then, when
>> a customer demands that the kernel version be exactly the
>> same that was shipped with Fedora or whatever, I'm screwed.
>
> If you didn't have the foresight to keep that kernel version around,
> there isn't much we can do to help you.  Yes, this may mean you have
> a big bunch of /usr/src/linux-2.6.* directories.
>

Wrong. Whoever put the module-loading code INSIDE the kernel,
for POLITICAL reasons, created a new POLICY.

[SNIPPED...]



Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
