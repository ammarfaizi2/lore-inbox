Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262557AbVG2VFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbVG2VFr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 17:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbVG2VDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 17:03:25 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:47488 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262557AbVG2VCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 17:02:12 -0400
Subject: Re: Broke nice range for RLIMIT NICE
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>, Michael Kerrisk <mtk-manpages@gmx.net>,
       mingo@elte.hu, linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net,
       akpm@osdl.org
In-Reply-To: <20050729205120.GJ19052@shell0.pdx.osdl.net>
References: <32710.1122563064@www32.gmx.net>
	 <20050729061318.GD7425@waste.org>
	 <20050729201836.GH19052@shell0.pdx.osdl.net>
	 <20050729205120.GJ19052@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Fri, 29 Jul 2005 17:02:09 -0400
Message-Id: <1122670930.9381.25.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-29 at 13:51 -0700, Chris Wright wrote:
> * Chris Wright (chrisw@osdl.org) wrote:
> > Yes, this requires updated pam patch.
> 
> Here's the updated pam patch.  I left the lower end at 0 rather than 1,
> since it's no harm.
>  
> +/* Hack to test new rlimit values */

Does this still apply?  If so what would a better solution look like?

Lee

