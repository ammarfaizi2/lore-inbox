Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135796AbRDTE3V>; Fri, 20 Apr 2001 00:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135797AbRDTE3K>; Fri, 20 Apr 2001 00:29:10 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:9158 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S135796AbRDTE3B>;
	Fri, 20 Apr 2001 00:29:01 -0400
Message-ID: <3ADFBB09.AA8BE439@mandrakesoft.com>
Date: Fri, 20 Apr 2001 00:28:57 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Per-Henrik Persson <vajper@whatever.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BP6: APIC, rtl8139 & sound
In-Reply-To: <Pine.LNX.4.21.0104200558310.12410-100000@RoadRunner.mhk.lu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per-Henrik Persson wrote:
> If i start to use the NIC, like som browsing on the internet i occassionly
> get:
> 
> eth0: Too much work at interrupt, IntrStatus=0x0001.

You need the 8139too driver update, from 2.4.4-pre5, 2.4.3-ac7, or
http://sourceforge.net/projects/gkernel/

-- 
Jeff Garzik       | "The universe is like a safe to which there is a
Building 1024     |  combination -- but the combination is locked up
MandrakeSoft      |  in the safe."    -- Peter DeVries
