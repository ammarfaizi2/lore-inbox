Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312194AbSDIXVo>; Tue, 9 Apr 2002 19:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312208AbSDIXVn>; Tue, 9 Apr 2002 19:21:43 -0400
Received: from 66-133-183-62.fod.frontiernet.net ([66.133.183.62]:7066 "EHLO
	66-133-183-62.fod.frontiernet.net") by vger.kernel.org with ESMTP
	id <S312194AbSDIXVn>; Tue, 9 Apr 2002 19:21:43 -0400
Message-Id: <200204092257.g39Mvrb30910@66-133-183-62.fod.frontiernet.net>
Content-Type: text/plain; charset=US-ASCII
From: Russell Miller <rmiller@duskglow.com>
Reply-To: rmiller@duskglow.com
Organization: If you only saw my house...
To: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 data corruption issues
Date: Tue, 9 Apr 2002 17:57:50 -0500
X-Mailer: KMail [version 1.3.2]
Cc: barry@Know-Where.com (Barry Bakalor)
In-Reply-To: <200204090252.g392qNb24499@66-133-183-62.fod.frontiernet.net> <200204090604.g3964rX01196@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 April 2002 06:08 am, Denis Vlasenko wrote:

> What is your GCC version?
>
2.96 20000731 (Redhat Linux 7.1 2.96-98)

> It was Linux? What kernel version? Did you try copying with that kernel?
>
Kernel 2.2.16.  I believe we did but we didn't verify the copies, regardless, 
we never found any problems with it.

> You may try to repeat your test with:
> * newer / older kernel (maybe this is a kernel bug?)
> * newer GCC (miscompiled kernel?)
> * different fs (ext3 bug?)
> * different hardware (last resort to rule out hw problems)

I'll do this.  I doubt it's a miscompiled kernel, gcc problems usually cause 
crashes, not such subtle problems.

--Russell

-- 
Russell Miller
rmiller@duskglow.com
Somewhere in Northwestern Iowa
