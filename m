Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131352AbRCKHZw>; Sun, 11 Mar 2001 02:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131355AbRCKHZm>; Sun, 11 Mar 2001 02:25:42 -0500
Received: from cold.fortyoz.org ([64.40.111.214]:51462 "HELO cold.fortyoz.org")
	by vger.kernel.org with SMTP id <S131352AbRCKHZc>;
	Sun, 11 Mar 2001 02:25:32 -0500
Date: Sat, 10 Mar 2001 23:25:29 -0800
From: David Raufeisen <david@fortyoz.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re:  2.4.3pre1: kernel BUG at page_alloc.c:73!
Message-ID: <20010310232529.A5734@fortyoz.org>
Reply-To: David Raufeisen <david@fortyoz.org>
In-Reply-To: <20010310231250.A5391@fortyoz.org> <15534.984295197@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <15534.984295197@ocs3.ocs-net>; from "Keith Owens" on Sunday, 11 March 2001, at 18:19:57 (+1100)
X-Operating-System: Linux 2.2.17 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, after looking more closely I noticed (nvrmapi.lib), i've only had two lockups ever with
it .. er in 2d at least (in 6 months), today and yesterday, kinda weird :)

On Sunday, 11 March 2001, at 18:19:57 (+1100),
Keith Owens wrote:

> That is just the glue code that nvidia uses to fool people.  The kernel
> module just creates a device that the main nvidia driver abuses to
> bypass all the kernel checks.  The real code is a 2M binary only blob.

-- 
David Raufeisen <david@fortyoz.org>
Cell: (604) 818-3596
