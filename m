Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267437AbUHJF2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267437AbUHJF2Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 01:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267438AbUHJF2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 01:28:15 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:391 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267437AbUHJF2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 01:28:05 -0400
Subject: Re: 2.4.x vs 2.6.x: denormal handling and audio performance
From: Lee Revell <rlrevell@joe-job.com>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       jackit-devel <jackit-devel@lists.sourceforge.net>
In-Reply-To: <1092105353.16799.848.camel@cmn37.stanford.edu>
References: <1092079195.16794.257.camel@cmn37.stanford.edu>
	 <1092099606.22613.12.camel@mindpipe>
	 <1092105353.16799.848.camel@cmn37.stanford.edu>
Content-Type: text/plain
Message-Id: <1092115700.761.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 01:28:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 22:35, Fernando Pablo Lopez-Lezcano wrote:
> _BUT_ 
> 
> [frantically trying to find a big brown bag to hide in... sigh...]
> 
> I retested with 2.4.x under FC1 yet again and I do see the same
> effect... argh... [*]
> 

Regardless, these numbers still are interesting.  Would any kernel
developer care to explain them?  It looks like a 50% difference in
performance from 2.4 to 2.6:

On Mon, 2004-08-09 at 10:49, Fernando Pablo Lopez-Lezcano wrote: 
> Athlon64 3000+, 2.6 (glibc 2.3.3, FC2): 27.5x
> 
> P4 Mobile, 2.6 (glibc 2.3.3, FC2):      191x
> P4 Mobile, 2.4 (glibc 2.3.2, FC1):      315x

Lee


