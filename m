Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbUKCOag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbUKCOag (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 09:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbUKCOag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 09:30:36 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:35007 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261616AbUKCOad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 09:30:33 -0500
Subject: Re: IT/ITE 8212 IDE Controller Status
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Tabor <jimtabor@adsl-64-217-116-74.dsl.hstntx.swbell.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <418893F2.30604@adsl-64-217-116-74.dsl.hstntx.swbell.net>
References: <418893F2.30604@adsl-64-217-116-74.dsl.hstntx.swbell.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099488449.29694.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 03 Nov 2004 13:27:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on it. Some people (notably those with rev 0x10) are hitting
bugs in smart mode I need to deal with yet. Also there are a couple of
core changes it depends upon which Bartlomiej should be merging and then
some new changes I've proposed to clean stuff up.

It's getting there bit by bit.

