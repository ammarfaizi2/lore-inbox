Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbUK3Mf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbUK3Mf7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 07:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbUK3Mf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 07:35:59 -0500
Received: from canuck.infradead.org ([205.233.218.70]:6661 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262049AbUK3Mfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 07:35:52 -0500
Subject: Re: [lkdump-develop] Re: [ANNOUNCE 0/7] Diskdump 1.0 Release
From: Arjan van de Ven <arjan@infradead.org>
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, lkdump-develop@lists.sourceforge.net
In-Reply-To: <43C4D67A05B46Dindou.takao@jp.fujitsu.com>
References: <1101732313.2814.63.camel@laptop.fenrus.org>
	 <43C4D67A05B46Dindou.takao@jp.fujitsu.com>
Content-Type: text/plain
Message-Id: <1101818140.2640.49.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 30 Nov 2004 13:35:40 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 10:15 +0900, Takao Indoh wrote:
> On Mon, 29 Nov 2004 13:45:13 +0100, Arjan van de Ven wrote:
> 
> >>
> >> I think kexec-dump is not stable yet.
> >
> >Do you have any facts to back this up? Is your project more stable ?
> >What is the success rate of dumps of diskdump ? How does that compare to
> >kexec-dump under the same circumstances ?
> 
> Sorry, a word "stable" was not appropriate. I meant that kexec-dump was
> under development yet. 

well diskdump seems to be quite under development as well; only a subset
of drivers is supported and your latest release just added initial
support for several architectures.

> kexec-dump works well on i386/x86_64, but it is
> in the development stage on other architectures.

not too different from diskdump then...

> 
> >> I heard that kexec-dump of
> >> some architecture (ex. ia64) had some problems and not worked.
> >
> >wouldn't it be better to then help finish that rather than making an
> >alternative ? 
> 
> It is, if diskdump project just started now. But the basic code of
> diskdump is almost completed. I think it is more efficient to enhance 
> quality of diskdump than help kexec-dump.

You are obviously free to spend your time wherever you want to, even though I do not agree with your reasoning.

