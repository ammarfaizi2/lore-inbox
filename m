Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265802AbUFIScB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265802AbUFIScB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 14:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265805AbUFIScB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 14:32:01 -0400
Received: from winds.org ([68.75.195.9]:33963 "EHLO winds.org")
	by vger.kernel.org with ESMTP id S265802AbUFISb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 14:31:59 -0400
Date: Wed, 9 Jun 2004 14:31:59 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in ncpfs
In-Reply-To: <20040609182706.GC2950@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.60.0406091430380.14198@winds.org>
References: <20040609122002.GD21168@wohnheim.fh-wedel.de>
 <Pine.LNX.4.60.0406091414140.14198@winds.org> <20040609182706.GC2950@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1262750147-508558299-1086805919=:14198"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1262750147-508558299-1086805919=:14198
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 9 Jun 2004, Jörn Engel wrote:

> On Wed, 9 June 2004 14:15:19 -0400, Byron Stanoszek wrote:
>>
>> Jörn, do you have any analysis of stack usage for x86-64 or other 64-bit
>> processors? I assume they would more readily reach the 4K stack boundaries
>> as all longs and pointers are 8 bytes instead of 4.
>
> No I don't, the tool isn't even tested on anything but i386.  Do any
> 64bit architectures use 4k stacks?

Guess not :)  I thought I saw it as an option on my x86-64 here but I guess I
was compiling too many different kernels this week.

Sorry for the mixup!

  -Byron

--
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com
--1262750147-508558299-1086805919=:14198--
