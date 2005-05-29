Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVE2Bgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVE2Bgf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 21:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVE2Bgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 21:36:35 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:34725 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261204AbVE2Bge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 21:36:34 -0400
Subject: Re: The values of gettimeofday() jumps.
From: Lee Revell <rlrevell@joe-job.com>
To: Liangchen Zheng <zlc@dream.eng.uci.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000201c563ee$eed993d0$85a4c380@dream.eng.uci.edu>
References: <000201c563ee$eed993d0$85a4c380@dream.eng.uci.edu>
Content-Type: text/plain
Date: Sat, 28 May 2005 21:36:32 -0400
Message-Id: <1117330593.5423.108.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-05-28 at 18:37 -0700, Liangchen Zheng wrote:
> Hello,
> 	We have several SMP machines (Tyan Tiger MPX motherboard, 2
> AthlonMP 1900+ CPU, linux-2.4.21-20.EL).  When running some time
> sensitive programs, I observed that the values of gettimeofday () jumped
> sometimes on a couple of machines (other machines are fine), from
> several hundreds milliseconds to a couple of seconds. 

Are you running NTP on those machines by any chance?

Lee

