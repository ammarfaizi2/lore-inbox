Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbUCQApi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 19:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbUCQApi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 19:45:38 -0500
Received: from main.gmane.org ([80.91.224.249]:61413 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261887AbUCQApd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 19:45:33 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Status HPT374 (HighPoint 1540) Sata in 2.6
Date: Wed, 17 Mar 2004 01:45:31 +0100
Message-ID: <yw1xhdwogv2s.fsf@kth.se>
References: <405786EC.5000803@matchmail.com> <40578F31.5090700@matchmail.com>
 <405796B0.9070906@matchmail.com>
 <200403170127.33424.bzolnier@elka.pw.edu.pl>
 <40579E51.1000709@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti211310a080-2480.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:nAwQO3wAWQn5eVjGRK17nlsChxc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> writes:

> Bartlomiej Zolnierkiewicz wrote:
>> I think that it may work with drivers/ide/hpt366.c
>> AFAIK HPT374 is PATA only chipset and SATA support in HighPoint 1540
>> is achieved by using PATA-SATA bridges.
>
> Does that limit you to 133MB/s speeds?

I'd like to a disk achieve even half of that.

> And does that mean no hot-swap?

Probably.

-- 
Måns Rullgård
mru@kth.se

