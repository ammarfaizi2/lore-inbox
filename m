Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbUDEVYA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbUDEVWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:22:00 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:63117 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S263258AbUDEVVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:21:20 -0400
Date: Mon, 5 Apr 2004 15:21:18 -0600 (MDT)
From: Stephen Smoogen <smoogen@lanl.gov>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel stack challenge
In-Reply-To: <4071CF6E.4030104@techsource.com>
Message-ID: <Pine.LNX.4.58.0404051516210.24230@smoogen1.lanl.gov>
References: <20040405205412.60071.qmail@web40504.mail.yahoo.com>
 <4071CF6E.4030104@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Apr 2004, Timothy Miller wrote:

>Sergiy Lozovsky wrote:
>
>> 
>> 
>> All LISP errors are incapsulated within LISP VM.
>>  
>
>
>A LISP VM is a big, giant, bloated.... *CHOKE* *COUGH* *SPUTTER* 
>*SUFFOCATE* ... thing which SHOULD NEVER be in the kernel.

Ah your thinking of the days when 1 meg of memory was a lot and LISP was 
considered huge..  With 4 gigs of memory today, it shouldnt be a problem 
:). Actually a LISP vm can fit into a small amount of memory depending 
on what you want it to do... 

I think in the end, this is a 'When all you know is to hammer, 
everything is a nail.' They know LISP.

>Why do you choose LISP?  Don't you want to use a language that sysadmins 
>will actually KNOW?

Because how else can you get emacs to the only thing to run?

-- 
Stephen John Smoogen		smoogen@lanl.gov
Los Alamos National Lab  CCN-5 Sched 5/40  PH: 4-0645
Ta-03 SM-1498 MailStop B255 DP 10S  Los Alamos, NM 87545
-- You should consider any operational computer to be a security problem --
