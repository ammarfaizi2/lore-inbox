Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWA3PgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWA3PgR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 10:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWA3PgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 10:36:17 -0500
Received: from xenotime.net ([66.160.160.81]:6030 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932330AbWA3PgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 10:36:16 -0500
Date: Mon, 30 Jan 2006 07:36:14 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Ed Sweetman <safemode@comcast.net>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.16-rc1-mm2 pata driver confusion
In-Reply-To: <1138621403.31089.46.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0601300734430.17839@shark.he.net>
References: <Pine.LNX.4.58.0601250846210.29859@shark.he.net>
 <1138621403.31089.46.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2006, Alan Cox wrote:

> > I just tested my system with a Plextor PX-712SA drive plus
> > booting with libata.atapi_enabled=1 and the driver (not nv)
> > sees the ATAPI drive and can read it.
>
> Parse error ;)
>
> What driver is "the driver" ?

Oh, it was generic in that sentence, just not nv.
I was using libata-core + libata-scsi + ahci + scsi infrastructure.
Maybe I should have said "the drivers."  8;)

-- 
~Randy
