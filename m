Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135443AbRDWPwN>; Mon, 23 Apr 2001 11:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135456AbRDWPwE>; Mon, 23 Apr 2001 11:52:04 -0400
Received: from fe100.worldonline.dk ([212.54.64.211]:13073 "HELO
	fe100.worldonline.dk") by vger.kernel.org with SMTP
	id <S135443AbRDWPvt>; Mon, 23 Apr 2001 11:51:49 -0400
Message-ID: <3AE4512F.5000005@eisenstein.dk>
Date: Mon, 23 Apr 2001 17:58:39 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-mosix i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en, da
MIME-Version: 1.0
To: Sean Hunter <sean@dev.sportingbet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pedantic code cleanup - am I wasting my time with this?
In-Reply-To: <3AE449A3.3050601@eisenstein.dk> <20010423164840.A29013@dev.sportingbet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Hunter wrote:

> On Mon, Apr 23, 2001 at 05:26:27PM +0200, Jesper Juhl wrote:
>> last entry should not have a trailing comma.
>> 
> 
> Sadly not.  This isn't a gcc thing: ANSI says that trailing comma is ok (K&R
> Second edition, A8.7 - pg 218 &219 in my copy)
> 

You are right, I just consulted my own copy, and nothing strictly 
forbids the comma... Sorry about that, I should have been more thorough 
before reporting that one...

- Jesper Juhl

