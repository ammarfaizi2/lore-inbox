Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266971AbTADMCO>; Sat, 4 Jan 2003 07:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266972AbTADMCO>; Sat, 4 Jan 2003 07:02:14 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:39600 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S266971AbTADMCN>; Sat, 4 Jan 2003 07:02:13 -0500
Subject: Re: odd phenomenon.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030104115724.GA3876@codemonkey.org.uk>
References: <20030103103816.GA2567@codemonkey.org.uk>
	 <1041677313.642.2.camel@zion.wanadoo.fr>
	 <20030104115724.GA3876@codemonkey.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1041682421.641.6.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 04 Jan 2003 13:13:41 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-04 at 12:57, Dave Jones wrote:
> Maybe, but bk was the only disk-thrashing type app I regularly
> have running when I've tried to reproduce this.
> 
> Is your PPC32 box SMP ?  I'm wondering why I don't see it on my
> athlon/P3 boxes, just on my dual P4.

No, it happens on my UP laptop as well. Hadess suggested it could be
yet-another gconf race in gnome

Ben.



