Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290756AbSBLEd3>; Mon, 11 Feb 2002 23:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290760AbSBLEdS>; Mon, 11 Feb 2002 23:33:18 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:38602 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S290756AbSBLEdN>;
	Mon, 11 Feb 2002 23:33:13 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15464.39685.717074.844068@napali.hpl.hp.com>
Date: Mon, 11 Feb 2002 20:33:09 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, davidm@hpl.hp.com, anton@samba.org,
        linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: thread_info implementation
In-Reply-To: <20020211.202108.77059987.davem@redhat.com>
In-Reply-To: <15464.36074.246502.582895@napali.hpl.hp.com>
	<20020211.194222.34761071.davem@redhat.com>
	<15464.38684.48286.317465@napali.hpl.hp.com>
	<20020211.202108.77059987.davem@redhat.com>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 11 Feb 2002 20:21:08 -0800 (PST), "David S. Miller" <davem@redhat.com> said:

  DaveM> The "loads are fast
  DaveM> on x86" comment I made is basically derived from something he
  DaveM> told someone else earlier today wrt. the thread_info stuff.

  DaveM> So let me rephrase what you've quoted "I totally beg to
  DaveM> differ, and I _know_ people like Linus will too." :-)

And I know that Linus rejected earlier patches (from Nov 2001) on
these grounds.

	--david
