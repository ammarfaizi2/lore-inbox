Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbTANPdZ>; Tue, 14 Jan 2003 10:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbTANPdY>; Tue, 14 Jan 2003 10:33:24 -0500
Received: from zeke.inet.com ([199.171.211.198]:6131 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S263760AbTANPdX>;
	Tue, 14 Jan 2003 10:33:23 -0500
Message-ID: <3E242FCC.5020803@inet.com>
Date: Tue, 14 Jan 2003 09:42:04 -0600
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rodrigobaroni@yahoo.com.br
CC: linux-kernel@vger.kernel.org
Subject: Re: Docs to a beginner
References: <20030114150521.94386.qmail@web11102.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rodrigo F. Baroni wrote:
> Hello all,
> 
> 
>     I'm a computer science grad student, and I would
> like to know some suggestions about links, docs and
> books to start study the kernel linux, if wouldn't
> bother anyone.

It's in the FAQ linked at the bottom of this message.  In particular, 
http://www.tux.org/lkml/#blkd

>     I like assembly a lot too. Is there some good
> place to work with assembly in Linux that is very
> applicable ?

linux/include/<arch>-asm
linux/arch/<arch>
find linux -name \*.S

HTH,

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

