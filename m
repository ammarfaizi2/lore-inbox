Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269006AbUINFU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269006AbUINFU2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 01:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269031AbUINFU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 01:20:28 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:51115 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269006AbUINFU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 01:20:26 -0400
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
From: Lee Revell <rlrevell@joe-job.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrea Arcangeli <andrea@novell.com>,
       Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <41460283.3020909@tmr.com>
References: <20040910153421.GD24434@devserv.devel.redhat.com>
	 <593560000.1094826651@[10.10.2.4]>
	 <1095016687.1306.667.camel@krustophenia.net>  <41460283.3020909@tmr.com>
Content-Type: text/plain
Message-Id: <1095139224.1752.14.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Sep 2004 01:20:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-13 at 16:26, Bill Davidsen wrote:
> Certainly if you run ppp the serial port won't like being ignored that 
> long, and if you pull down data on a parallel port that really won't 
> like it. The soundcard is probably only a problem if you're recording 
> input, in spite of some posts here about skipping, the world doesn't end 
> if you get a skip, although 2ms shouldn't cause that anyway.

The world also doesn't end if your web server returns a "Server too
busy" error either.

Sorry, wrong answer.

Lee

