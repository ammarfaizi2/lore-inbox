Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263049AbTC1Q5l>; Fri, 28 Mar 2003 11:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263050AbTC1Q5l>; Fri, 28 Mar 2003 11:57:41 -0500
Received: from [81.2.110.254] ([81.2.110.254]:5116 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S263049AbTC1Q5l>;
	Fri, 28 Mar 2003 11:57:41 -0500
Subject: Re: x.25 bug
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tiaan Wessels <tiaan@netsys.co.za>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200303280600.h2S60YC02395@tiaan.netsys.co.za>
References: <200303280600.h2S60YC02395@tiaan.netsys.co.za>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048871417.5055.27.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Mar 2003 17:10:18 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-28 at 06:00, Tiaan Wessels wrote:
> [4.] Kernel version (from /proc/version):
> Linux version 2.4.7-10 (bhcompile@stripples.devel.redhat.com) (gcc version 
> 2.96
> 20000731 (Red Hat Linux 7.1 2.96-98)) #1 Thu Sep 6 17:27:27 EDT 2001

Start by updating the kernel to the recommended errata kernel and see if
that fixes it. My initial suspicion is not, but its the right starting
point

