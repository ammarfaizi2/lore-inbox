Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271570AbTGQS2G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271573AbTGQS2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:28:04 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:7433
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S271570AbTGQSZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:25:31 -0400
Date: Thu, 17 Jul 2003 11:40:33 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Mike Martin <redtuxxx@yahoo.co.uk>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel oops with 2.5.74 2.5.75
Message-ID: <20030717184033.GB1003@matchmail.com>
Mail-Followup-To: Mike Martin <redtuxxx@yahoo.co.uk>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	linux-kernel@vger.kernel.org
References: <20030716013133.GA2681@matchmail.com> <20030717082218.43874.qmail@web60005.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030717082218.43874.qmail@web60005.mail.yahoo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 09:22:18AM +0100, Mike Martin wrote:
>  --- Mike Fedyk <mfedyk@matchmail.com> wrote: > On Mon, Jul 14, 2003
> at 09:35:32PM +0100, Mike Martin wrote:
> > >  --- Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
> > > wrote: > 
> > > > Please send dmesg with oops
> > > > (make sure you have CONFIG_KALLSYMS enabled).
> > > > 
> > > 
> > > just updated to 2.6-test1 with the same result
> > > I attach the output on the screen (written down and copied, so
> > may be
> > > errors)
> > 
> > what was the EIP? 
> 
> Apart from 2.5.68 the eip cant be seen (screen scrolls past)
> for 2.5.68 it is
> 
> EIP 0060:[<01b97427>] Not Tainted
> EFLAGS 00010046

Sorry, the numbers are machine specific, there should be a line below that
says "EIP is at ...".

