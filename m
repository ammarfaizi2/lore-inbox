Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbTARHd5>; Sat, 18 Jan 2003 02:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbTARHd5>; Sat, 18 Jan 2003 02:33:57 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:36308 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S263215AbTARHd4>;
	Sat, 18 Jan 2003 02:33:56 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15913.1396.22808.83238@napali.hpl.hp.com>
Date: Fri, 17 Jan 2003 23:42:44 -0800
To: Andrew Morton <akpm@digeo.com>
Cc: Anton Blanchard <anton@samba.org>, akpm@zip.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: recent change to exit_mmap
In-Reply-To: <20030117224444.08c48290.akpm@digeo.com>
References: <20030118060522.GE7800@krispykreme>
	<20030117224444.08c48290.akpm@digeo.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 17 Jan 2003 22:44:44 -0800, Andrew Morton <akpm@digeo.com> said:

  Andrew> Looks like ia64 needs work, too...

Yes, should be the same problem there.  The fix looks fine to me.
(Let's just hope I remember it when Linus puts it in his tree...).

Thanks,

	--david
