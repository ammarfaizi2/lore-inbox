Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVG0EYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVG0EYB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 00:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVG0EYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 00:24:01 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:64165 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261287AbVG0EYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 00:24:00 -0400
Subject: Re: 2.6.12 sound problem
From: Lee Revell <rlrevell@joe-job.com>
To: sclark46@earthlink.net
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42E6C8DB.4090608@earthlink.net>
References: <42E6C8DB.4090608@earthlink.net>
Content-Type: text/plain
Date: Wed, 27 Jul 2005 00:23:58 -0400
Message-Id: <1122438238.13598.19.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-26 at 19:35 -0400, Stephen Clark wrote:
> Additional info I don't see any interrupts in /proc/interrupts for the
> Allegro which is on int 5.
> I just tried the same laptop with knoppix and a 2.4.27 kernel and sound
> works great and I do
> see interrupts for Allegro on int 5.

So the same ALSA driver works on 2.6 but fails on 2.4?  Or are you
really saying 2.4 + the OSS driver works and 2.6 + ALSA does not?

Lee

