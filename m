Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266053AbUALEKe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 23:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266054AbUALEKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 23:10:34 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18439 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S266053AbUALEKd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 23:10:33 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: loop device changes the block size and causes misaligned accessesto
    the real device, which can't be processed
Date: Sun, 11 Jan 2004 23:12:04 -0500
Organization: TMR Associates, Inc
Message-ID: <btt60u$3gq$2@gatekeeper.tmr.com>
References: <3FFC3BF4.6080105@ugr.es> <3FFC4BF1.B6A5ADAE@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1073879902 3610 192.168.12.10 (12 Jan 2004 03:58:22 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <3FFC4BF1.B6A5ADAE@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jari Ruusu wrote:
> Ruben Garcia wrote:
> 
>>The loop device advertises a block size of 1024 even when configured
>>over a cdrom.
> 
> 
> This bug and many other loop bugs are fixed in loop-AES package.
> 
> http://loop-aes.sourceforge.net/loop-AES/loop-AES-v2.0d.tar.bz2

This would be really useful in the mainline kernel...

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
