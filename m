Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbTEUWoI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 18:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbTEUWoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 18:44:08 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:9288 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262316AbTEUWoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 18:44:06 -0400
Date: Wed, 21 May 2003 15:55:39 -0700
From: Andrew Morton <akpm@digeo.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: must-fix list, v5
Message-Id: <20030521155539.51ecc0e6.akpm@digeo.com>
In-Reply-To: <20030521224928.GA774@ip68-0-152-218.tc.ph.cox.net>
References: <20030521152255.4aa32fba.akpm@digeo.com>
	<20030521152334.4b04c5c9.akpm@digeo.com>
	<20030521224928.GA774@ip68-0-152-218.tc.ph.cox.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 May 2003 22:57:09.0283 (UTC) FILETIME=[4EE43F30:01C31FEC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org> wrote:
>
> I talked with RMK on IRC a bit about this.  After reading
> drivers/char/rtc.c, I think this can be vastly simplied to:
> Add support for alarms to the existing generic rtc driver
> (drivers/char/genrtc.c).
> 
> Does this sound like a plan?

It certainly does, thanks.
