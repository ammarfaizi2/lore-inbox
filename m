Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267607AbUJLTeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267607AbUJLTeN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 15:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267659AbUJLTeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 15:34:13 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:9965 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267607AbUJLTd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 15:33:57 -0400
Subject: Re: sound problems in 2.6.8.1 w/ EMU10K1
From: Lee Revell <rlrevell@joe-job.com>
To: Richard Hubbell <richard.hubbell@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <c25b25320410121205586f32f4@mail.gmail.com>
References: <c25b25320410121205586f32f4@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1097609610.1553.87.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 12 Oct 2004 15:33:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 15:05, Richard Hubbell wrote:
> I can provide more context if you think it will help.  Should this go
> to ALSA instead?
> 

Try the latest ALSA version (1.0.7-rc2) before you file a bug.

Also, hw:0,3 is the SPDIF device.  Sounds like you are not using normal
computer speakers.  Are you using digital speakers or SPDIF out to a
receiver?

Please answer off-list or post your report to alsa-user as this is OT
for LKML.

Lee


