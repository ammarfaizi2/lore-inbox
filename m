Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132807AbREHP5M>; Tue, 8 May 2001 11:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132825AbREHP5C>; Tue, 8 May 2001 11:57:02 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:3805 "EHLO
	c0mailgw13.prontomail.com") by vger.kernel.org with ESMTP
	id <S132807AbREHP4x>; Tue, 8 May 2001 11:56:53 -0400
Message-ID: <3AF81720.A1E15AAE@mvista.com>
Date: Tue, 08 May 2001 08:56:16 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@melbourne.sgi.com>
CC: kdb@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: kdb wishlist
In-Reply-To: <23270.989323782@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> This is part of my kdb wishlist, does anybody fancy writing the code to
> add any of these features?  It would be a nice project for anybody
> wanting to start on the kernel.  Replies to kdb@oss.sgi.com please.
> Current patches at http://oss.sgi.com/projects/kdb/download/
> 
> * Change kdb invocation key from ^A to ^X^X^X within 3 seconds.  ^A is
>   used by emacs, bash, minicom etc.
> 
^X^X swaps point and mark in emacs.  One (well, I) often will do
^X^X^X^X to examine where mark is and then return to point.

George

~snip
