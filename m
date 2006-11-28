Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752629AbWK1WkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbWK1WkB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754368AbWK1WkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:40:01 -0500
Received: from mout0.freenet.de ([194.97.50.131]:9347 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S1752629AbWK1WkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:40:00 -0500
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: Ingo Molnar <mingo@elte.hu>,
       "Fernando Lopez-Lezcano" <nando@ccrma.stanford.edu>
Subject: Re: 2.6.19-rc6-rt8
Date: Tue, 28 Nov 2006 23:40:21 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20061127094927.GA7339@elte.hu>
In-Reply-To: <20061127094927.GA7339@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611282340.21317.fzu@wemgehoertderstaat.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 27. November 2006 10:49 schrieb Ingo Molnar:
> i have released the 2.6.19-rc6-rt8 tree, which can be downloaded from 

I saw usb transport errors here before rebooting with
	nmi_watchdog=0
contained in kernel command line.

Testcase stalled within 2 minutes before change,
ticks happily after change for 15 minutes now.
.config is a "release" type, no debugging options.

      Karsten
