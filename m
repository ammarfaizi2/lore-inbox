Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267840AbUHES2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267840AbUHES2W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267878AbUHES1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:27:37 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:48458 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267840AbUHESIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:08:19 -0400
Message-ID: <bec878da040805110871bf70cc@mail.gmail.com>
Date: Thu, 5 Aug 2004 11:08:18 -0700
From: "Kevin O'Shea" <mastergoon@gmail.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: USB troubles in rc2
Cc: Michael Guterl <mguterl@gmail.com>, linux-usb-devel@lists.sourceforge.net,
       "Luis Miguel =?ISO-8859-1?Q?=20Garc=FD?= Mancebo" <ktech@wanadoo.es>,
       Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
In-Reply-To: <200408050834.27452.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200408022100.54850.ktech@wanadoo.es> <200408041820.50199.david-b@pacbell.net> <944a037704080420574bb181f8@mail.gmail.com> <200408050834.27452.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just thought you guys would like to know I had this same problem since
2.6.7-mm6, but it is now fixed for me in 2.6.8-rc3-mm1.

I have an intel 865PE chipset.
