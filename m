Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131296AbRCKGzb>; Sun, 11 Mar 2001 01:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131300AbRCKGzM>; Sun, 11 Mar 2001 01:55:12 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:2833 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131296AbRCKGzK>;
	Sun, 11 Mar 2001 01:55:10 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Raufeisen <david@fortyoz.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3pre1: kernel BUG at page_alloc.c:73! 
In-Reply-To: Your message of "Sat, 10 Mar 2001 22:14:27 -0800."
             <20010310221427.A5415@fortyoz.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 11 Mar 2001 17:54:23 +1100
Message-ID: <15189.984293663@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Mar 2001 22:14:27 -0800, 
David Raufeisen <david@fortyoz.org> wrote:
>Mar 10 21:34:30 prototype kernel:        [free_pages+36/48] [NVdriver:osFreeContigPages+79/84] [<cda1d004>] [NVdriver:RmTeardownAGP+156/176] [<cfa70000>] [NVdriver:nv_devices+0/384] [NVdriver:nvExtEscape+2888/3100] [<

Bug caused by binary only driver.  Complain to nvidia, not linux-kernel.

