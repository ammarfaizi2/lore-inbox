Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274231AbRIXWsu>; Mon, 24 Sep 2001 18:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274228AbRIXWsa>; Mon, 24 Sep 2001 18:48:30 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:55310 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S274227AbRIXWsU>;
	Mon, 24 Sep 2001 18:48:20 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Timur Tabi <ttabi@interactivesi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tainting kernels for non-GPL or forced modules 
In-Reply-To: Your message of "Mon, 24 Sep 2001 13:00:24 EST."
             <3BAF74B8.6070102@interactivesi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Sep 2001 08:48:29 +1000
Message-ID: <12332.1001371709@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2001 13:00:24 -0500, 
Timur Tabi <ttabi@interactivesi.com> wrote:
>Keith Owens wrote:
>
>> I have started work on the patch for /proc/sys/kernel/tainted with the
>> corresponding modutils and ksymoops changes.  insmod of a non-GPL
>> module ORs /proc/sys/kernel/tainted with 1, insmod -f ORs with 2.
>
>Where can I find more information about this?  The word "tainted" doesn't 
>appear in my kernel source code (I guess 2.4.2 is too old), and a search on 
>google didn't reveal anything.

http://marc.theaimsgroup.com/?l=linux-kernel&m=99922065229945&w=2 and
the rest of the thread.

