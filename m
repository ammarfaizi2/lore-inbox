Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268727AbUIGXJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268727AbUIGXJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 19:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268742AbUIGXJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 19:09:56 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:8116 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268727AbUIGXJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 19:09:55 -0400
Subject: Re: Possible network issue in 2.6.8.1
From: Lee Revell <rlrevell@joe-job.com>
To: Joris Neujens <joris@discosmash.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409071544570.6867@asus.discosmash.com>
References: <Pine.LNX.4.58.0409071544570.6867@asus.discosmash.com>
Content-Type: text/plain
Message-Id: <1094598598.16954.215.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 07 Sep 2004 19:09:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-07 at 09:55, Joris Neujens wrote:
> Hello,
> 
> We've got a weird problem at our university network.  Since we upgraded to
> kernel 2.6.8 our download rate never gets higher than 10kB/sec.  Upload
> remains at original rate.  This problem does not occur with previous
> kernels (works fine again after downgrading to 2.6.7, without changing
> anything at the kernel config).
> 

This is quickly becoming a FAQ:

http://lwn.net/Articles/92727/

Short answer: you have a broken router.

Lee

