Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVBPT5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVBPT5c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 14:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVBPT5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 14:57:32 -0500
Received: from mol92-1-81-57-137-188.fbx.proxad.net ([81.57.137.188]:44160
	"EHLO laptop.okeru") by vger.kernel.org with ESMTP id S261857AbVBPT5Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 14:57:16 -0500
Message-ID: <4213A5D5.8070802@oreka.com>
Date: Wed, 16 Feb 2005 20:58:13 +0100
From: Alexandre <a.hocquel_NOSPAM_@oreka.com>
Reply-To: a.hocquel@oreka.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: strange bug with realtek 8169 card
References: <3yBMF-2kO-3@gated-at.bofh.it> <3yBMG-2kO-5@gated-at.bofh.it> <3yBMF-2kO-1@gated-at.bofh.it> <3yCfH-2Em-1@gated-at.bofh.it> <3yCfJ-2Em-7@gated-at.bofh.it> <3yCzf-2Rt-27@gated-at.bofh.it> <3yD2j-3mf-23@gated-at.bofh.it> <3yDbS-3tr-31@gated-at.bofh.it>
In-Reply-To: <3yDbS-3tr-31@gated-at.bofh.it>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> shishir verma <shishir.lkml@gmail.com> :
> 
>>by any chance is the watchdog enabled for the card...because i had a
>>similar problem with a broadcom gigabit card....i commented the
>>watchdog code and made the module again...
>>it worked like a charm for me after that...
> 
> 
> The original user wrote:
> [...]
> 
>>>If I look in every log file I can (dmesg, kernel.log, syslog, debug)
>>>there is no message...
> 
> 
> -> the watchdog would have caused something to appear.
> 
> I'd rather have a bit more information before resorting to super-voodoo.
thanks again, unfortunately PCs with those cards are at work, and from 
today that's holidays until march 7th... :D
so I can't test last solution (patch) until this day...

Alex, who will try maybe tomorrow to go there if he has time
