Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271349AbTGQIH3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 04:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271353AbTGQIH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 04:07:29 -0400
Received: from web60005.mail.yahoo.com ([216.109.116.228]:48825 "HELO
	web60005.mail.yahoo.com") by vger.kernel.org with SMTP
	id S271349AbTGQIH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 04:07:28 -0400
Message-ID: <20030717082218.43874.qmail@web60005.mail.yahoo.com>
Date: Thu, 17 Jul 2003 09:22:18 +0100 (BST)
From: =?iso-8859-1?q?Mike=20Martin?= <redtuxxx@yahoo.co.uk>
Subject: Re: Kernel oops with 2.5.74 2.5.75
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030716013133.GA2681@matchmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Mike Fedyk <mfedyk@matchmail.com> wrote: > On Mon, Jul 14, 2003
at 09:35:32PM +0100, Mike Martin wrote:
> >  --- Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
> > wrote: > 
> > > Please send dmesg with oops
> > > (make sure you have CONFIG_KALLSYMS enabled).
> > > 
> > 
> > just updated to 2.6-test1 with the same result
> > I attach the output on the screen (written down and copied, so
> may be
> > errors)
> 
> what was the EIP? 

Apart from 2.5.68 the eip cant be seen (screen scrolls past)
for 2.5.68 it is

EIP 0060:[<01b97427>] Not Tainted
EFLAGS 00010046

__________________________________________________
Yahoo! Plus - For a better Internet experience
http://uk.promotions.yahoo.com/yplus/yoffer.html
