Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264703AbSIQXu7>; Tue, 17 Sep 2002 19:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264708AbSIQXu7>; Tue, 17 Sep 2002 19:50:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:53380 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264703AbSIQXu6>;
	Tue, 17 Sep 2002 19:50:58 -0400
Date: Tue, 17 Sep 2002 16:46:49 -0700 (PDT)
Message-Id: <20020917.164649.110499262.davem@redhat.com>
To: ak@suse.de
Cc: johnstul@us.ibm.com, jamesclv@us.ibm.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, anton.wilson@camotion.com
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020918015209.B31263@wotan.suse.de>
References: <1032305535.7481.204.camel@cog>
	<20020917.163246.113965700.davem@redhat.com>
	<20020918015209.B31263@wotan.suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Wed, 18 Sep 2002 01:52:09 +0200

   On Tue, Sep 17, 2002 at 04:32:46PM -0700, David S. Miller wrote:
   > I know full well it isn't currently :-)
   
   Sorry, it's wrong. The x86 architecture has several such registers

Not in the processor, and not architectually specified.

All of the things you list are in the scope of things outside
the cpu.
