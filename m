Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130764AbRBSTUU>; Mon, 19 Feb 2001 14:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130113AbRBSTUJ>; Mon, 19 Feb 2001 14:20:09 -0500
Received: from relay03.valueweb.net ([216.219.253.237]:27402 "EHLO
	relay03.valueweb.net") by vger.kernel.org with ESMTP
	id <S130764AbRBSTTz>; Mon, 19 Feb 2001 14:19:55 -0500
Message-ID: <3A917324.A27728F1@opersys.com>
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Michael McLeod <michaelm@platypus.net>
CC: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: monitoring I/O
In-Reply-To: <8494866EDB1D3E4F9C7E6AC2F95C259B01DA1C@plat.platypus.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Feb 2001 14:19:42 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I caught this one a little bit late, but you might want to take
a peek at the Linux Trace Toolkit:

http://www.opersys.com/LTT

You'll be able to monitor I/O at will.

Best regards,

Karim

> Michael McLeod wrote:
> 
> Hello
> 
> I am hoping someone can give me a little information or point me in the right direction.  I would like to write an application that monitors I/O on
> a linux machine, but I need some help in determining where to get the information I'm looking for.  What I would like to do is 'hook' into the
> kernel and record information such as volume name, type of request (read or write), the amount of data being read or written, how long each
> transaction takes....
> 
> Any help would be greatly appreciated, or if there is something like this already available that would be even better.  Thanx
> 
> Mike

-- 
===================================================
                 Karim Yaghmour
               karym@opersys.com
          Operating System Consultant
 (Linux kernel, real-time and distributed systems)
===================================================
