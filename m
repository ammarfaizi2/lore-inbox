Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313926AbSDJX0H>; Wed, 10 Apr 2002 19:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313927AbSDJX0G>; Wed, 10 Apr 2002 19:26:06 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:8697 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S313926AbSDJX0F>; Wed, 10 Apr 2002 19:26:05 -0400
Date: Wed, 10 Apr 2002 16:26:04 -0700
From: Chris Wright <chris@wirex.com>
To: Niki Rahimi <narahimi@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Getting file attributes
Message-ID: <20020410162604.B1550@figure1.int.wirex.com>
Mail-Followup-To: Niki Rahimi <narahimi@us.ibm.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <OF201A5533.4F892774-ON85256B97.007A3CEE@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Niki Rahimi (narahimi@us.ibm.com) wrote:
> Hi All,
>       I have been working on finding a system call that will retrieve the
> current file's attributes, especially the file owner and permissions. have
> seen VOP_GETATTR()  in OpenBSD, which returns such information in a
> structure. Is there anything equivalent to this on the Linux kernel?
>        I've been searching through the kernel code for something equivalent
> but my paths have lead me nowhere.

does stat(2) have what you're lookig for??

cheers,
-chris
