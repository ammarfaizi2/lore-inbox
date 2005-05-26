Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVEZXMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVEZXMk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 19:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVEZXMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 19:12:39 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:16771 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261708AbVEZXMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 19:12:38 -0400
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
From: Lee Revell <rlrevell@joe-job.com>
To: 7eggert@gmx.de
Cc: Bill Davidsen <davidsen@tmr.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1DbQHp-0001LK-M2@be1.7eggert.dyndns.org>
References: <48cRq-7TH-5@gated-at.bofh.it> <48cRq-7TH-7@gated-at.bofh.it>
	 <48cRq-7TH-3@gated-at.bofh.it> <48dDM-5I-1@gated-at.bofh.it>
	 <48wdp-7lh-1@gated-at.bofh.it>  <E1DbQHp-0001LK-M2@be1.7eggert.dyndns.org>
Content-Type: text/plain
Date: Thu, 26 May 2005 19:12:36 -0400
Message-Id: <1117149156.6705.14.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-26 at 23:53 +0200, Bodo Eggert wrote:
> If I need RT privileges, I'll need to suid untill the non-root RT support
> is ready and I'll be glad that it's supported.

It is in 2.6.12-rc5.  You need to patch PAM (and bash, if you want to
use ulimit) to use it.

Lee

