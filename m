Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263504AbTH0QA1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 12:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263530AbTH0QA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 12:00:26 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:60689
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263504AbTH0QAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 12:00:22 -0400
Date: Wed, 27 Aug 2003 09:00:20 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, John Stultz <johnstul@us.ibm.com>
Subject: Re: Compile problem with CONFIG_X86_CYCLONE_TIMER Re: 2.6.0-test4-mm1
Message-ID: <20030827160020.GA4119@matchmail.com>
Mail-Followup-To: Dave Hansen <haveblue@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, John Stultz <johnstul@us.ibm.com>
References: <20030827010849.GA5280@matchmail.com> <1061959279.12881.6.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061959279.12881.6.camel@nighthawk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 09:41:19PM -0700, Dave Hansen wrote:
> On Tue, 2003-08-26 at 18:08, Mike Fedyk wrote:
> > This patch to my .config makes it compile:
> 
> I tried 2.6.0-test4-mm1 with your config and didn't have any problems. 
> Could you check with your old config to make sure I'm not missing
> something?

did you try with gcc 2.95?
