Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261520AbSKGQuq>; Thu, 7 Nov 2002 11:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261521AbSKGQuq>; Thu, 7 Nov 2002 11:50:46 -0500
Received: from franka.aracnet.com ([216.99.193.44]:7577 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261520AbSKGQup>; Thu, 7 Nov 2002 11:50:45 -0500
Date: Thu, 07 Nov 2002 08:51:24 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Bill Davidsen <davidsen@tmr.com>, Andrew Morton <akpm@digeo.com>
cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.46-mm1
Message-ID: <4051130868.1036659083@[10.10.2.3]>
In-Reply-To: <Pine.LNX.3.96.1021107113557.30525C-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1021107113557.30525C-100000@gatekeeper.tmr.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For what it's worth, the last mm kernel which booted on my old P-II IDE
> test machine was 44-mm2. With 44-mm6 and this one I get an oops on boot.
> Unfortunately it isn't written to disk, scrolls off the console, and
> leaves the machine totally dead to anything less than a reset. I will try

Any chance of setting up a serial console? They're very handy for 
things like this ...

M.

