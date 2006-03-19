Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWCSB5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWCSB5f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 20:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWCSB5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 20:57:35 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:31150 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751215AbWCSB5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 20:57:34 -0500
Subject: Re: 2.6.16-rc6-mm2: new RDMA CM EXPORT_SYMBOL's
From: Lee Revell <rlrevell@joe-job.com>
To: tom@opengridcomputing.com
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Sean Hefty <sean.hefty@intel.com>, linux-kernel@vger.kernel.org,
       Roland Dreier <rolandd@cisco.com>, openib-general@openib.org
In-Reply-To: <1142732643.8247.6.camel@bigtime.es335.com>
References: <20060318044056.350a2931.akpm@osdl.org>
	 <20060318172507.GC14608@stusta.de>
	 <1142732643.8247.6.camel@bigtime.es335.com>
Content-Type: text/plain
Date: Sat, 18 Mar 2006 20:57:28 -0500
Message-Id: <1142733449.2863.14.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-18 at 19:44 -0600, Tom Tucker wrote:
> I apologize in advance for my ignorance, but I don't understand how
> 'new symbols' could pass the test of 'currently used'. 
> 

Normally when adding new exports you would submit the code that uses
them at the same time.

Lee

