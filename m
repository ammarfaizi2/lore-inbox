Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131308AbRCKHNM>; Sun, 11 Mar 2001 02:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131309AbRCKHNC>; Sun, 11 Mar 2001 02:13:02 -0500
Received: from cold.fortyoz.org ([64.40.111.214]:49670 "HELO cold.fortyoz.org")
	by vger.kernel.org with SMTP id <S131308AbRCKHMx>;
	Sun, 11 Mar 2001 02:12:53 -0500
Date: Sat, 10 Mar 2001 23:12:50 -0800
From: David Raufeisen <david@fortyoz.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re:  2.4.3pre1: kernel BUG at page_alloc.c:73!
Message-ID: <20010310231250.A5391@fortyoz.org>
Reply-To: David Raufeisen <david@fortyoz.org>
In-Reply-To: <20010310221427.A5415@fortyoz.org> <15189.984293663@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <15189.984293663@ocs3.ocs-net>; from "Keith Owens" on Sunday, 11 March 2001, at 17:54:23 (+1100)
X-Operating-System: Linux 2.2.17 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, the kernel module is open source..

On Suday, 11 March 2001, at 17:54:23 (+1100),
Keith Owens wrote:

> On Sat, 10 Mar 2001 22:14:27 -0800, 
> David Raufeisen <david@fortyoz.org> wrote:
> >Mar 10 21:34:30 prototype kernel:        [free_pages+36/48] [NVdriver:osFreeContigPages+79/84] [<cda1d004>] [NVdriver:RmTeardownAGP+156/176] [<cfa70000>] [NVdriver:nv_devices+0/384] [NVdriver:nvExtEscape+2888/3100] [<
> 
> Bug caused by binary only driver.  Complain to nvidia, not linux-kernel.

-- 
David Raufeisen <david@fortyoz.org>
Cell: (604) 818-3596
