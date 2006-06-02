Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWFBNkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWFBNkN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 09:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWFBNkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 09:40:13 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:38242 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751420AbWFBNkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 09:40:11 -0400
Date: Fri, 2 Jun 2006 15:40:09 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: "Abu M. Muttalib" <abum@aftek.com>
Cc: linux-kernel@vger.kernel.org, k.oliver@t-online.de, jes@sgi.com
Subject: Re: __alloc_pages: 0-order allocation failed (Jes Sorensen)
Message-ID: <20060602134009.GE2051@harddisk-recovery.nl>
References: <20060602122016.GC2051@harddisk-recovery.com> <BKEKJNIHLJDCFGDBOHGMAEKKCNAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMAEKKCNAA.abum@aftek.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I leave quotations after my reply?

On Fri, Jun 02, 2006 at 07:00:26PM +0530, Abu M. Muttalib wrote:
> I anticipated that my application which was running perfectly on
> linux-2.4.19-rmk7-pxa1 box will run as it is on linux-2.6.13 box as well.
> But alas, this is not the case and I fail to understand why it is so? ;-(

I can't tell you. I don't have the source of your application and I my
crystal ball is getting old so I can't read the kernel messages from
your screen.

Anyway, try to recreate the problem with a *recent* 2.6 kernel. If you
can still recreate your problem, post a log over here.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
