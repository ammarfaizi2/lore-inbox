Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbTDRViJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 17:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263261AbTDRViJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 17:38:09 -0400
Received: from [12.47.58.203] ([12.47.58.203]:16507 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263260AbTDRViI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 17:38:08 -0400
Date: Fri, 18 Apr 2003 14:48:42 -0700
From: Andrew Morton <akpm@digeo.com>
To: Toon van der Pas <toon@hout.vanvergehaald.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm4
Message-Id: <20030418144842.687af1e2.akpm@digeo.com>
In-Reply-To: <20030418154911.GA16046@hout.vanvergehaald.nl>
References: <20030418014536.79d16076.akpm@digeo.com>
	<20030418154911.GA16046@hout.vanvergehaald.nl>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Apr 2003 21:50:01.0462 (UTC) FILETIME=[767DC960:01C305F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Toon van der Pas <toon@hout.vanvergehaald.nl> wrote:
>
> >   My recommendation, as always, is to disable SCSI TCQ completely.  If you
> >   really must, set it to four tags.
> 
> What about drivers that bypass de SCSI layer?

Nobody knows what will happen actually.   Good point.

> I administer a server with a Mylex RAID controller (DAC960)...

I shall dig out my ExTrEmErAiD2000 and run the tests.

