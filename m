Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbTKTFBg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 00:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264267AbTKTFBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 00:01:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:54763 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264266AbTKTFBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 00:01:34 -0500
Date: Wed, 19 Nov 2003 20:57:39 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: neilb@cse.unsw.edu.au, wli@holomorphy.com, jgarzik@pobox.com,
       jt@hpl.hp.com, linux-kernel@vger.kernel.org, pof@users.sourceforge.net
Subject: Re: Announce: ndiswrapper
Message-Id: <20031119205739.5ffa5c13.rddunlap@osdl.org>
In-Reply-To: <3FBC47C1.6040209@cyberone.com.au>
References: <20031120031137.GA8465@bougret.hpl.hp.com>
	<3FBC3483.4060706@pobox.com>
	<20031120040034.GF19856@holomorphy.com>
	<3FBC402E.6070109@cyberone.com.au>
	<16316.17526.900850.239502@notabene.cse.unsw.edu.au>
	<3FBC47C1.6040209@cyberone.com.au>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Nov 2003 15:49:05 +1100 Nick Piggin <piggin@cyberone.com.au> wrote:

| Neil Brown wrote:
| 
| >On Thursday November 20, piggin@cyberone.com.au wrote:
| >
| >>You have to admit its good for end users though. And indirectly, what
| >>is good for them is good for us. Take the nvidia example: end users get
| >>either a binary driver or nothing. If we were somehow able to stop
| >>nvidia from distributing their binary driver, they would say "OK".
| >>
| >
| >Is it good for end users?  It allows them to buy a computer with an
| >nvidia graphics controller because "NVidia supply drivers", and then
| >discover that support is only as good as NVidia are willing to make
| >it.  I'm still waiting for some sort of power management support for
| >the nvidia controller in my notebook.  If the driver and the specs
| >were open, I could possibly do it myself.  On the other hand if there
| >were no NVidia drivers, I never would have made the (arguable) mistake
| >of buying this notebook.
| >
| 
| I'm all for open specs, but in reality that doesn't always happen.
| (out of interest, are there any OS 3d drivers for any current cards?)
| 
| I know what you mean, but I would find nvidia more at fault for not
| providing power management than no OS drivers.
| 
| >
| >Ofcourse we cannot and should not stop people from providing the
| >option of binary only drivers, but I'm not convinced that we should
| >acknowlege that people who provide binary-only drivers are doing a
| >useful service for anyone but themselves.
| >
| 
| No I wouldn't say that, I meant the Linux Kernel is doing the end users
| a favour by allowing binary modules.

that's questionable since we can't support them (i.e. fix bugs/problems
with them).

--
~Randy
