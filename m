Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136920AbREJUsf>; Thu, 10 May 2001 16:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136921AbREJUs0>; Thu, 10 May 2001 16:48:26 -0400
Received: from tomts6.bellnexxia.net ([209.226.175.26]:41671 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S136920AbREJUsP>; Thu, 10 May 2001 16:48:15 -0400
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: ATAPI Tape Driver Failure in Kernel 2.4.4, More
To: linux-kernel@vger.kernel.org
Date: Thu, 10 May 2001 16:48:13 -0400
In-Reply-To: <3AF9558F.9C76953C@tpr.com> <3AF9B411.2A0F3F43@tpr.com> <3AF9B876.FDB1B6DD@bigfoot.com> <3AFA8A1D.A9BBB4DF@tpr.com> <3AFAD0DC.90510557@windsormachine.com>
Organization: me
User-Agent: KNode/0.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20010510204813.856F56A69@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Dresser wrote:

> Mark Bratcher wrote:
> 
>>
>> This all works OK in kernel 2.2.17. But it fails in 2.4.4.
>> > hdd: HP COLORADO 20GB, ATAPI TAPE drive
> 
> I did my own playing with 2.4.x on the 14gb model of this tape drive, all i've managed
> to do is be able to write to the tape, but not read from it.  Even in 2.2.x, putting the
> IDE patches in, breaks it.  Apparently the HP's aren't completely ATAPI compatible

I can write my HP 20GB drive with ide-tape.  For restores I use ide-scsi.  Its a bit of a 
hack but does work around the problem.

Ed Tomlinson <tomlins@cam.org>

