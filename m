Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288670AbSADPdR>; Fri, 4 Jan 2002 10:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288671AbSADPdI>; Fri, 4 Jan 2002 10:33:08 -0500
Received: from [212.16.7.124] ([212.16.7.124]:1154 "HELO laputa.namesys.com")
	by vger.kernel.org with SMTP id <S288670AbSADPcz>;
	Fri, 4 Jan 2002 10:32:55 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15413.51356.829757.566177@laputa.namesys.com>
Date: Fri, 4 Jan 2002 18:22:04 +0300
To: dan kelley <dkelley@otec.com>
Cc: Ingo Molnar <mingo@elte.hu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.33.0201041806400.9733-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0201040945430.9085-100000@nixon.bos.otec.net>
	<Pine.LNX.4.33.0201041806400.9733-100000@localhost.localdomain>
X-Mailer: VM 7.00 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
 > 
 > On Fri, 4 Jan 2002, dan kelley wrote:
 > 
 > > using the 2.4.17 patch against a vanilla 2.4.17 tree, looks like there's a
 > > problem w/ reiserfs:
 > 
 > please check out the -A1 patch, this should be fixed.

As a temporary solution you can also compile without reiserfs procinfo
support.

 > 
 > 	Ingo

Nikita.

 > 
