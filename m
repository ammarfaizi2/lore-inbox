Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWBEUVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWBEUVI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 15:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWBEUVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 15:21:08 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:22658 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750717AbWBEUVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 15:21:06 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [PATCH ]  VMSPLIT config options (with default config fixed)
To: Jan Engelhardt <jengelh@linux01.gwdg.de>, Mark Lord <lkml@rtr.ca>,
       Ulrich Mueller <ulm@kph.uni-mainz.de>,
       Herbert Poetzl <herbert@13thfloor.at>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Reply-To: 7eggert@gmx.de
Date: Sun, 05 Feb 2006 21:20:55 +0100
References: <5trTo-7aS-25@gated-at.bofh.it> <5trTo-7aS-23@gated-at.bofh.it> <5ts37-7nG-23@gated-at.bofh.it> <5tsZ0-lL-3@gated-at.bofh.it> <5tuor-2zh-63@gated-at.bofh.it> <5tvaL-3MA-77@gated-at.bofh.it> <5tvDG-4nl-47@gated-at.bofh.it> <5tvDF-4nl-45@gated-at.bofh.it> <5twTa-6cF-25@gated-at.bofh.it> <5txcv-6OX-31@gated-at.bofh.it> <5ByEo-3fj-7@gated-at.bofh.it> <5BKvR-3gt-25@gated-at.bofh.it> <5BTJ2-fP-3@gated-at.bofh.it> <5ChUM-2f8-21@gated-at.bofh.it> <5CtsV-1zF-3@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1F5qNU-0000kq-FO@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

>> Mmm.. bad idea.  As much as I'd like the default to be 3GB_OPT, that would
>> be a big impact to userspace, and there's no point in breaking everyone's
>> machines when advanced users can just reconfig/recompile to get what they
>> want.
>>
> What userspace programs do depend on it?

As far as I understand, user mode linux.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
