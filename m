Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbWBECYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWBECYR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 21:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWBECYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 21:24:17 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:1941 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932215AbWBECYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 21:24:16 -0500
Subject: Re: athlon 64 dual core tsc out of sync
From: Lee Revell <rlrevell@joe-job.com>
To: Albert Cahalan <acahalan@gmail.com>
Cc: linux-kernel@vger.kernel.org, s0348365@sms.ed.ac.uk, safemode@comcast.net
In-Reply-To: <787b0d920602041745k65504414taaaef7f6d75b364c@mail.gmail.com>
References: <787b0d920602041224p660911b5mc4d639581736e96f@mail.gmail.com>
	 <1139101243.2791.78.camel@mindpipe>
	 <787b0d920602041745k65504414taaaef7f6d75b364c@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 04 Feb 2006 21:24:13 -0500
Message-Id: <1139106254.2791.91.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-04 at 20:45 -0500, Albert Cahalan wrote:
> Clock ticks get lost all the time. The BIOS may decide do grab the
> CPU in SMM (system management mode) for many milliseconds at a time. 

And FWIW such systems should be considered horribly broken - this
behavior renders them useless for a wide range of common applications.

Lee

