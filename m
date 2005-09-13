Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVIMKLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVIMKLR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 06:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVIMKLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 06:11:17 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:15504
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750711AbVIMKLQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 06:11:16 -0400
Subject: Re: Problems with 2.6.13-rt5
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050913094351.GX28883@pengutronix.de>
References: <20050913094351.GX28883@pengutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 13 Sep 2005 12:11:23 +0200
Message-Id: <1126606283.6509.156.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-13 at 11:43 +0200, Robert Schwebel wrote:
> Hi Ingo, 
> 
> Time is somehow more broken with -rt5 than with -rt4: 
> 
> europa:~# date --set="Tue Sep 13 10:57:00 CEST 2005"
> Tue Sep 13 10:57:00 CEST 2005
> europa:~# date
> Thu Jan  1 01:03:49 CET 1970

Can you please send me your .config file ?

> Running the hrttimers-support-dev tests shows several errors

Which errors ?

tglx




