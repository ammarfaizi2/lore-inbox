Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269122AbUHYCBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269122AbUHYCBs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 22:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269130AbUHYCBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 22:01:47 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:44476 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269122AbUHYCA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 22:00:57 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P9
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Scott Wood <scott@timesys.com>, manas.saksena@timesys.com,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040824061459.GA29630@elte.hu>
References: <20040823221816.GA31671@yoda.timesys>
	 <20040824061459.GA29630@elte.hu>
Content-Type: text/plain
Message-Id: <1093399257.5678.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 24 Aug 2004 22:00:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 02:14, Ingo Molnar wrote:

>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P9
> 

Here is an 815 usec latency triggered by mounting a 120GB ext3
partition:

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P9#/var/www/2.6.8.1-P9/trace3.txt

Lee

