Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbVKWUWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVKWUWS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbVKWUWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:22:18 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:26603 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932301AbVKWUWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:22:17 -0500
Subject: Re: [BUG 2579] linux 2.6.* sound problems
From: Lee Revell <rlrevell@joe-job.com>
To: patrizio.bassi@gmail.com
Cc: Ard van Breemen <ard@kwaak.net>, linux-kernel@vger.kernel.org
In-Reply-To: <4384CB8B.6040409@gmail.com>
References: <53L1x-6dC-13@gated-at.bofh.it> <53LkE-6QU-5@gated-at.bofh.it>
	 <53LkW-6QU-49@gated-at.bofh.it> <53LEq-7gr-7@gated-at.bofh.it>
	 <43667406.9070104@gmail.com> <4366A49F.3000101@rainbow-software.org>
	 <43673B6F.5030909@gmail.com>  <20051123162216.GG1700@kwaak.net>
	 <1132775178.10453.14.camel@mindpipe>  <4384CB8B.6040409@gmail.com>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 15:22:08 -0500
Message-Id: <1132777329.10453.21.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-23 at 21:05 +0100, Patrizio Bassi wrote:
> it seems both.
> now i'm using 1000hz with 0x40 latency.
> i still get some noises but lower than before (lat = 0x20).
> 
> however i saw you marked it closed as hardware problem, i'm sure it
> isn't.
> 
> it' a linux 2.6 problem for me, as 2.4 and windows works perfectly.
> stop :)
> a windows copy, running under vmware on linux 2.6, seems to work good
> too.
> 

If the noise is caused by higher HZ settings then that is a hardware
problem.  Windows and Linux 2.4 use a lower HZ setting than Linux 2.6.

Lee

