Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315420AbSFTT0w>; Thu, 20 Jun 2002 15:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315421AbSFTT0v>; Thu, 20 Jun 2002 15:26:51 -0400
Received: from fwvan1.pyr.ec.gc.ca ([199.212.20.2]:14469 "HELO
	siebs.pyr.ec.gc.ca") by vger.kernel.org with SMTP
	id <S315420AbSFTT0u>; Thu, 20 Jun 2002 15:26:50 -0400
Message-ID: <3D122C76.9000906@sieb.net>
Date: Thu, 20 Jun 2002 12:26:46 -0700
From: Samuel Sieb <samuel@sieb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020619
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 Assert
References: <3D122589.4060301@sieb.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the bother.  I've been told by 2 people so far that it's known 
and fixed in 2.4.18-4smp.

Samuel Sieb wrote:

> I upgraded a computer yesterday from Redhat 7.2 to 7.3 and got this 
> assert not long after.
>
> /proc/version:
> Linux version 2.4.18-3smp (bhcompile@daffy.perf.redhat.com) (gcc 
> version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 SMP Thu Apr 18 
> 07:27:31 EDT 2002
>
> This is what was in the syslog:
> kernel: Assertion failure in journal_commit_transaction() at 
> commit.c:535: "buffer_jdirty(bh)"
> kernel: ------------[ cut here ]------------
> kernel: kernel BUG at commit.c:535!
>

