Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313362AbSDOXPF>; Mon, 15 Apr 2002 19:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313366AbSDOXPE>; Mon, 15 Apr 2002 19:15:04 -0400
Received: from prv-mail20.provo.novell.com ([137.65.81.122]:6947 "EHLO
	prv-mail20.provo.novell.com") by vger.kernel.org with ESMTP
	id <S313362AbSDOXPE>; Mon, 15 Apr 2002 19:15:04 -0400
Message-Id: <scbb0a8c.058@prv-mail20.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.0.1
Date: Mon, 15 Apr 2002 17:15:12 -0600
From: "David Rorke" <DRORKE@volera.com>
To: <linux-kernel@vger.kernel.org>
Subject: eepro100 and zero copy transmit
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Are there any plans to add zero copy transmit support to the eepro100
driver?

In looking at the archives from a year or so ago, I noticed that at
that time there was
no support in the driver because of difficulties in identifying which
cards have the
necessary hardware csum and scatter/gather support.   Is this still the
problem?

If there are no plans to add this to eepro100.c, does anyone know if
the Intel
provided driver in addon/e100 will be supporting this soon?

Thanks,

Dave Rorke
