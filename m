Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVHBOMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVHBOMI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 10:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVHBOJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 10:09:43 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:27113 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261541AbVHBOHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 10:07:15 -0400
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: James Bruce <bruce@andrew.cmu.edu>, David Weinehall <tao@acc.umu.se>,
       Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050802112529.GA7954@elf.ucw.cz>
References: <20050730195116.GB9188@elf.ucw.cz>
	 <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz>
	 <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz>
	 <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz>
	 <1122852234.13000.27.camel@mindpipe>
	 <20050801074447.GJ9841@khan.acc.umu.se> <42EE4B4A.80602@andrew.cmu.edu>
	 <20050802112529.GA7954@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 10:07:11 -0400
Message-Id: <1122991631.5490.29.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 13:25 +0200, Pavel Machek wrote:
> BTW I think many architectures have HZ=100 even in 2.6, so it is not
> as siple as "go 2.6"...

Does not matter.  An app that only ever worked on 2.6 + x86 will break
on 2.6.13.

Lee

