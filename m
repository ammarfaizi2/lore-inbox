Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753375AbWKGVcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbWKGVcb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 16:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753376AbWKGVcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 16:32:31 -0500
Received: from mail1.key-systems.net ([81.3.43.253]:3477 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S1753375AbWKGVca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 16:32:30 -0500
Message-ID: <4550FB6B.4090807@scientia.net>
Date: Tue, 07 Nov 2006 22:32:27 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange write errors on FAT32 partition (maybe an FAT32 bug?!)
References: <4550A481.2010408@scientia.net> <87psbzrss2.fsf@duaron.myhome.or.jp>
In-Reply-To: <87psbzrss2.fsf@duaron.myhome.or.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:
> Christoph Anton Mitterer <calestyo@scientia.net> writes:
>
>   
>> The strange thing is that one time the differences were found directly
>> after copying (thus one would thing RAM is damaged, because the data was
>> probalby (I cannot tell this for sure) taken from file cache).
>> and the other time after restarting with a certainly empty file cache.
>>
>> Any ideas? I'm willing to help debugging and so on but I must admit that
>> I need someone to say me what to do :D
>>     
> bit interesting. Could you send the output of diff? I'd like to see
> how it's breaking.
>   
Unfortunately I don't have currently any of the corrupted files (deleted
them,..) but as soon as I'll encounter the issue again I'll send you :)

But as far as I remember there was no pattern,.. on time a small part
was replaced by 0x0's and the other time by any bytes.

Chris.

