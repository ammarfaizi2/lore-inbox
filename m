Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269716AbUHZVpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269716AbUHZVpZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269509AbUHZVoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:44:10 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:8380 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269709AbUHZVjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:39:35 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P9
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Scott Wood <scott@timesys.com>, manas.saksena@timesys.com,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040824061459.GA29630@elte.hu>
References: <20040823221816.GA31671@yoda.timesys>
	 <20040824061459.GA29630@elte.hu>
Content-Type: text/plain
Message-Id: <1093556379.5678.109.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 17:39:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 02:14, Ingo Molnar wrote:

>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P9
> 

Hmm, it seems that those strange ~1ms latencies are back.  This was
triggered by mounting an NTFS volume:

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P9#/var/www/2.6.8.1-P9/trace5.txt

Lee



