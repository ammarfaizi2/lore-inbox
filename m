Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290728AbSBLCb1>; Mon, 11 Feb 2002 21:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290720AbSBLCbR>; Mon, 11 Feb 2002 21:31:17 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:19184 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S290728AbSBLCbA>;
	Mon, 11 Feb 2002 21:31:00 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15464.32354.452126.182563@napali.hpl.hp.com>
Date: Mon, 11 Feb 2002 18:30:58 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, anton@samba.org, linux-kernel@vger.kernel.org,
        zippel@linux-m68k.org
Subject: Re: thread_info implementation
In-Reply-To: <20020211.182208.102575913.davem@redhat.com>
In-Reply-To: <15464.29104.798819.399971@napali.hpl.hp.com>
	<20020211.174102.28786938.davem@redhat.com>
	<15464.30088.754007.311391@napali.hpl.hp.com>
	<20020211.182208.102575913.davem@redhat.com>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 11 Feb 2002 18:22:08 -0800 (PST), "David S. Miller" <davem@redhat.com> said:

  DavidM> I implemented the thread_info stuff, and I checked out the
  DavidM> performance, have you?

So why don't you share the results?  Perhaps then I can see the light,
too.  With the exception of task coloring, the thread_info is strictly
more work and it's possible to do task coloring without thread_info.

	--david
