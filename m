Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265851AbSLSRaf>; Thu, 19 Dec 2002 12:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265863AbSLSRaf>; Thu, 19 Dec 2002 12:30:35 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:46756 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S265851AbSLSRad>; Thu, 19 Dec 2002 12:30:33 -0500
Message-ID: <3E020604.80703@kegel.com>
Date: Thu, 19 Dec 2002 09:46:44 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: re: Dedicated kernel bug database
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford <john@grabjohn.com> wrote:
> Following on from yesterday's discussion about there not being much
> interaction between the kernel Bugzilla and the developers, I began
> wondering whether Bugzilla might be a bit too generic to be suited to
> kernel development, and that maybe a system written from the ground up
> for reporting kernel bugs would be better?
> 
> I.E. I am prepared to write it myself, if people think it's
> worthwhile.

Quoting Linus (http://marc.theaimsgroup.com/?l=linux-kernel&m=103911905214446&w=2):
> And many things _can_ be done without throwing out old designs.
> Implementation improvements are quite possible without trying to make
> something totally new to the outside. ...
> 
> Not throwing out the baby with the bath-water doesn't mean that you cannot
> improve the system. I'm only arguing against stupid people who think they
> need a revolution to improve - most real improvements are evolutionary.

I bet the thing to do is to spend some time as one of the
elves who make bugzilla.kernel.org work smoothly despite
the software; then figure out what incremental tweak you
can make to the software to make the elves' and users' lives
better.

-- 
Dan Kegel
Linux User #78045
http://www.kegel.com

