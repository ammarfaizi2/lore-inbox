Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262936AbTHZPD6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 11:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262947AbTHZPD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 11:03:57 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:1181 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262936AbTHZPD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 11:03:56 -0400
Subject: Re: linux-2.2 future?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: adefacc@tin.it, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ruben =?ISO-8859-1?Q?P=FCttmann?= <ruben@puettmann.net>,
       Ville Herva <vherva@niksula.hut.fi>
In-Reply-To: <200308251815.20131.m.c.p@wolk-project.de>
References: <3F468ABD.1EBAD831@tin.it>
	 <200308251815.20131.m.c.p@wolk-project.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061910188.20846.39.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 26 Aug 2003 16:03:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-08-25 at 17:42, Marc-Christian Petersen wrote:
> like .21 and .22 IDE code is, but it works very very smooth and nice and rock 
> solid. We use the 2.2-secure tree for almost all customers in my company. 
> Biggest harddisk is a 160GB Maxtor IDE disk.

The problem is that change breaks stuff. a lot of the 2.2 users will
happily trade lack of LBA48 support for stability and predictability.
Thats why I took a basically "if its not a serious bugfix its not going
in" approach

