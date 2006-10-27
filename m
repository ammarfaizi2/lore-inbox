Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752330AbWJ0QL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbWJ0QL6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 12:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbWJ0QL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 12:11:57 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41095 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1752328AbWJ0QLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 12:11:42 -0400
Subject: Re: UCB1400 pxa2xx-ac97 failed with error -13 on PXA2xx
From: Lee Revell <rlrevell@joe-job.com>
To: saravanan_sprt@hotmail.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5263041.1161964209062.JavaMail.websites@opensubscriber>
References: <5263041.1161964209062.JavaMail.websites@opensubscriber>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 12:11:41 -0400
Message-Id: <1161965502.27225.111.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-27 at 23:50 +0800, saravanan_sprt@hotmail.com wrote:
> Hi, 
> I am facing the following problem with ALSA and UCB1400 codec on Colibri PXA270. After having applied Nicolas patches and platform entries in colibri.c, I get the following boot up error messages which annoys me a lot. 
> ......... 
> ts: UCB1x00 touchscreen protocol output
> ts: Compaq touchscreen protocol output 
> Colibri MMC/SD setup done. 
> Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 10:33:39 2005 UTC). 

Way too old to debug.  Try the latest kernel release.

Lee

