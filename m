Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268115AbUI2ApP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268115AbUI2ApP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 20:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268117AbUI2ApP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 20:45:15 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:2185 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268115AbUI2ApL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 20:45:11 -0400
Subject: Re: processor affinity
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Cc: Robert Love <rml@novell.com>, Ankit Jain <ankitjain1580@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41598B23.50702@drdos.com>
References: <20040928122517.9741.qmail@web52907.mail.yahoo.com>
	 <41596F7F.1000905@drdos.com>
	 <1096387088.4911.4.camel@betsy.boston.ximian.com>
	 <41598B23.50702@drdos.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096408318.13983.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 28 Sep 2004 22:51:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-28 at 17:02, Jeff V. Merkey wrote:
> >>http://patft.uspto.gov/netacgi/nph-Parser?Sect1=PTO2&Sect2=HITOFF&p=1&u=/netahtml/search-bool.html&r=2&f=G&l=50&co1=AND&d=ptxt&s1=merkey.INZZ.&OS=IN/merkey&RS=IN/merkey
> >Wow, I never knew about that.
> >
> >But guess who wrote the affinity system calls? :)

> I wrote them first, and coined the term. 

Cute but GCOS3 had affinity syscalls for batch processing in the 1970's
and I don't believe it was original even then.

