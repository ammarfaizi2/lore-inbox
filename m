Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290755AbSBLEXP>; Mon, 11 Feb 2002 23:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290756AbSBLEXG>; Mon, 11 Feb 2002 23:23:06 -0500
Received: from pizda.ninka.net ([216.101.162.242]:20616 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290755AbSBLEWy>;
	Mon, 11 Feb 2002 23:22:54 -0500
Date: Mon, 11 Feb 2002 20:21:08 -0800 (PST)
Message-Id: <20020211.202108.77059987.davem@redhat.com>
To: davidm@hpl.hp.com
Cc: anton@samba.org, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: thread_info implementation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15464.38684.48286.317465@napali.hpl.hp.com>
In-Reply-To: <15464.36074.246502.582895@napali.hpl.hp.com>
	<20020211.194222.34761071.davem@redhat.com>
	<15464.38684.48286.317465@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@hpl.hp.com>
   Date: Mon, 11 Feb 2002 20:16:28 -0800

   >>>>> On Mon, 11 Feb 2002 19:42:22 -0800 (PST), "David S. Miller" <davem@redhat.com> said:
   
     DaveM> I totally beg to
     DaveM> differ, and I think people like Linus will too.
   
   I don't think so.

Linus has actually told me and others his opinion of the patch, and he
has accepted it whole heartedly.  If he didn't accept it, it wouldn't
be in the tree right?

In fact, why don't you ask him yourself?  The "loads are fast on x86"
comment I made is basically derived from something he told someone
else earlier today wrt. the thread_info stuff.

So let me rephrase what you've quoted "I totally beg to differ, and I
_know_ people like Linus will too." :-)
