Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131809AbRDCOOd>; Tue, 3 Apr 2001 10:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131820AbRDCOOY>; Tue, 3 Apr 2001 10:14:24 -0400
Received: from jalon.able.es ([212.97.163.2]:37252 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131809AbRDCOOJ>;
	Tue, 3 Apr 2001 10:14:09 -0400
Date: Tue, 3 Apr 2001 16:13:22 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: David Lang <dlang@diginsite.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/config idea
Message-ID: <20010403161322.A8174@werewolf.able.es>
In-Reply-To: <3AC91800.22D66B24@mandrakesoft.com> <Pine.LNX.4.33.0104021734400.30128-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.33.0104021734400.30128-100000@dlang.diginsite.com>; from dlang@diginsite.com on Tue, Apr 03, 2001 at 02:39:19 +0200
X-Mailer: Balsa 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.03 David Lang wrote:
> 
> if the distro/sysadmin _always_ installs the kernel the 'right way' then
> the difference isn't nessasarily that large, but if you want reliability
> on any system it may be worth loosing a page or so of memory (hasn't
> someone said that the data can be compressed to <1K?) make it so that you
> need a common external tool to use the data and deliver it from the kernel
> in compressed form and you don't even need to put the decompression
> routine in the kernel (cat /proc/sys/kernel/config |gunzip >config)
> 

Just my 2 cents...

If this has not been done for System.map, that is a much more important
info for debug and oops, and the de facto standard is to put it aside
kernel with some standadr naming, lets use the same method for config.

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.3 #2 SMP Fri Mar 30 15:42:05 CEST 2001 i686

