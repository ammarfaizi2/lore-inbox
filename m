Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132855AbRDXH72>; Tue, 24 Apr 2001 03:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132862AbRDXH7S>; Tue, 24 Apr 2001 03:59:18 -0400
Received: from juicer14.bigpond.com ([139.134.6.23]:54257 "EHLO
	mailin2.email.bigpond.com") by vger.kernel.org with ESMTP
	id <S132855AbRDXH7G>; Tue, 24 Apr 2001 03:59:06 -0400
Message-Id: <m14rv59-001PKNC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dale Amon <amon@vnl.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Has the iptables security patch been vetted? 
In-Reply-To: Your message of "Mon, 23 Apr 2001 20:48:27 +0100."
             <20010423204825.H26083@vnl.com> 
Date: Tue, 24 Apr 2001 15:09:47 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20010423204825.H26083@vnl.com> you write:
> I'm sure you've run across this one:
> 
> 	http://netfilter.samba.org/security-fix/
> 
> I'd like to know how official this patch is, ie how
> well checked out?

Hi Dale,

	The preferred patch is available, and has been tested (several
new testsuite tests now exist) and submitted to Linus (et. al):

	http://netfilter.filewatcher.org/security-fix/ftp-security2.patch
	http://netfilter.samba.org/security-fix/ftp-security2.patch
	http://netfilter.gnumonks.org/security-fix/ftp-security2.patch

Hope that helps,
Rusty.
--
Premature optmztion is rt of all evl. --DK
