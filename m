Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263276AbVCJWLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263276AbVCJWLd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263257AbVCJWDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:03:37 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:55269 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263179AbVCJVw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 16:52:59 -0500
Subject: Re: 2.6.11 low latency audio test results
From: Lee Revell <rlrevell@joe-job.com>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       "Jack O'Quin" <joq@io.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <422F07C2.7080900@cybsft.com>
References: <1110324852.6510.11.camel@mindpipe>
	 <422F07C2.7080900@cybsft.com>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 16:52:57 -0500
Message-Id: <1110491577.14297.19.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 08:27 -0600, K.R. Foley wrote:
> Lee Revell wrote:
>  
> > Of course all of the above settings provide flawless xrun-free
> > performance with 2.6.11-rc4 + PREEMPT_RT.
> > 
> 
> The above mentioned patch will apply (and build and run) just fine to 
> 2.6.11 if you fix the EXTRAVERSION portion of the patch to not expect -rc4.
> 

Right, it sure does.  No rejects except the Makefile.

Looks like the release candidate process is getting tighter.

Lee

