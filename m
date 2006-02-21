Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161271AbWBUBwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161271AbWBUBwn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 20:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161272AbWBUBwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 20:52:43 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:51138 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161271AbWBUBwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 20:52:42 -0500
Subject: Re: [2.6.16-rc4] new ALSA bootmsg
From: Lee Revell <rlrevell@joe-job.com>
To: Kenneth Parrish <Kenneth.Parrish@familynet-international.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b0369c.549a49@familynet-international.net>
References: <b0369c.549a49@familynet-international.net>
Content-Type: text/plain
Date: Mon, 20 Feb 2006 20:52:39 -0500
Message-Id: <1140486760.6722.108.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-21 at 01:18 +0000, Kenneth Parrish wrote:
> boot:
> Loading 2.6.16-rc4
> BIOS data check successful
> Uncompressing Linux... Ok, booting the kernel.
> ALSA sound/isa/cs423x/cs4236.c:348: CS4236+ MPU401 PnP manual resources
> are invalid, using auto config
> ALSA sound/drivers/mpu401/mpu401_uart.c:479: mpu401_uart: unable to grab
> port 0x120 size 2
> [..]

Did you try Rene Herman's patch posted earlier today?

Lee

