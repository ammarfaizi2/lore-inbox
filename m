Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbSJVB5l>; Mon, 21 Oct 2002 21:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261972AbSJVB5l>; Mon, 21 Oct 2002 21:57:41 -0400
Received: from main.gmane.org ([80.91.224.249]:17872 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S261963AbSJVB5j>;
	Mon, 21 Oct 2002 21:57:39 -0400
To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
Path: not-for-mail
From: Nicholas Wourms <nwourms@netscape.net>
Subject: Re: [PATCH] 2.5.44: lkcd (9/9): dump driver and build files
Date: Mon, 21 Oct 2002 22:04:39 -0400
Message-ID: <ap2bk3$b0t$1@main.gmane.org>
References: <200210211016.g9LAG5J21214@nakedeye.aparity.com> <20021021172112.C14993@sgi.com>
Reply-To: nwourms@netscape.net
NNTP-Posting-Host: 130.127.121.177
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: main.gmane.org 1035252164 11293 130.127.121.177 (22 Oct 2002 02:02:44 GMT)
X-Complaints-To: usenet@main.gmane.org
NNTP-Posting-Date: Tue, 22 Oct 2002 02:02:44 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> On Mon, Oct 21, 2002 at 03:16:05AM -0700, Matt D. Robinson wrote:
>> diff -Naur linux-2.5.44.orig/drivers/dump/Makefile
>> linux-2.5.44.lkcd/drivers/dump/Makefile
>> --- linux-2.5.44.orig/drivers/dump/Makefile  Wed Dec 31 16:00:00 1969
>> +++ linux-2.5.44.lkcd/drivers/dump/Makefile  Sat Oct 19 12:39:15 2002
>> @@ -0,0 +1,30 @@
>> +#
>> +# Makefile for the dump device drivers.
>> +#
>> +# 12 June 2000, Christoph Hellwig <schch@pe.tu-clausthal.de>
>> +# Rewritten by Matt D. Robinson (yakker@sourceforge.net) for
>> +# the dump directory.
> 
> *cough* is that an old mail address and I can't even remember having
> touched that file.. :)  What about remoing that note..
> 

Didn't this used to be an SGI project?  Perhaps that is where you might have 
"touched" it.

Cheers,
Nicholas



