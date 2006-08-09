Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWHIQfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWHIQfa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWHIQfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:35:30 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:28135 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751018AbWHIQf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:35:29 -0400
Subject: Re: ALSA problems with 2.6.18-rc3
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Benton <b3nt@ukonline.co.uk>
Cc: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <44DA0D93.2080307@ukonline.co.uk>
References: <44D8F3E5.5020508@ukonline.co.uk>
	 <1155073853.26338.112.camel@mindpipe>  <44DA0D93.2080307@ukonline.co.uk>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 12:35:32 -0400
Message-Id: <1155141333.26338.186.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 17:30 +0100, Andrew Benton wrote:
> Lee Revell wrote:
> > Please try to identify the change that introduced the regression.  What
> > was the last kernel/ALSA version that worked correctly?
> 
> The change happened between 2.6.17 and 2.6.18-rc1. Specifically, 
> 2.6.17-git4 works and 2.6.17-git5 doesn't.

Takashi-san,

Does this help at all?  Many users are reporting that sound broke with
2.6.18-rc*.

Lee

