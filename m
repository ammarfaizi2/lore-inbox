Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751775AbWAEQtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbWAEQtQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 11:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbWAEQtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 11:49:15 -0500
Received: from outgoing.tpinternet.pl ([193.110.120.20]:48624 "EHLO
	outgoing.tpinternet.pl") by vger.kernel.org with ESMTP
	id S1751775AbWAEQtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 11:49:15 -0500
In-Reply-To: <Pine.LNX.4.61.0601051631260.10350@tm8103.perex-int.cz>
References: <20060105140155.GC757@jolt.modeemi.cs.tut.fi> <Pine.LNX.4.61.0601051518370.10350@tm8103.perex-int.cz> <20060105145101.GB28611@dspnet.fr.eu.org> <Pine.LNX.4.61.0601051631260.10350@tm8103.perex-int.cz>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B450D46D-7EB9-4F80-A3AB-4CDE948B6284@neostrada.pl>
Cc: Olivier Galibert <galibert@pobox.com>,
       Heikki Orsila <shd@modeemi.cs.tut.fi>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>
Content-Transfer-Encoding: 7bit
From: Marcin Dalecki <dalecki.marcin@neostrada.pl>
Subject: Re: [OT] ALSA userspace API complexity
Date: Thu, 5 Jan 2006 17:48:44 +0100
To: Jaroslav Kysela <perex@suse.cz>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006-01-05, at 16:33, Jaroslav Kysela wrote:
>> Make simple things simple, guys.
>
> Yes, we should stay with simple 1.0 linux kernel.

This blatant attempt to defend a broken subsystem by "analogy" fails  
because last time
I checked the semantics of system calls like read/write/open/close  
didn't
change significantly between kernel version 1.0 and 2.6.15.

The number of system calls didn't change that much as well.

Yes it may be true that some aggregation of exhaustive crappy  
interfaces over time
in the kernel can be indeed observed. However the very fact which  
makes it remain
still usable are precisely those very "primitive" system calls -  
which are still
around and kicking.
