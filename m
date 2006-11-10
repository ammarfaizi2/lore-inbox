Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424338AbWKJBtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424338AbWKJBtb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 20:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424342AbWKJBtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 20:49:31 -0500
Received: from mail.parknet.jp ([210.171.160.80]:44044 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1424338AbWKJBt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 20:49:29 -0500
X-AuthUser: hirofumi@parknet.jp
To: Christoph Anton Mitterer <calestyo@scientia.net>
Cc: linux-kernel@vger.kernel.org, Roger Heflin <rheflin@atipa.com>
Subject: Re: Strange write errors on FAT32 partition (maybe an FAT32 bug?!)
References: <4550A481.2010408@scientia.net>
	<87psbzrss2.fsf@duaron.myhome.or.jp> <4553AA5E.7090206@scientia.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 10 Nov 2006 10:49:20 +0900
In-Reply-To: <4553AA5E.7090206@scientia.net> (Christoph Anton Mitterer's message of "Thu\, 09 Nov 2006 23\:23\:26 +0100")
Message-ID: <87bqngjckf.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Anton Mitterer <calestyo@scientia.net> writes:

> OGAWA Hirofumi wrote:
>> Christoph Anton Mitterer <calestyo@scientia.net> writes:
>>   
>>> The strange thing is that one time the differences were found directly
>>> after copying (thus one would thing RAM is damaged, because the data was
>>> probalby (I cannot tell this for sure) taken from file cache).
>>> and the other time after restarting with a certainly empty file cache.
>>>
>>> Any ideas? I'm willing to help debugging and so on but I must admit that
>>> I need someone to say me what to do :D
>>>     
>>
>> bit interesting. Could you send the output of diff? I'd like to see
>> how it's breaking.
>>   
> I have now such a diff,... but where should I send it,.. it's quite big
> (21266 bytes)

I think it's not so big. If you care, please send it to me.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
