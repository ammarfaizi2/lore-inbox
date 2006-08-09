Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWHIQvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWHIQvN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWHIQvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:51:13 -0400
Received: from no-dns-yet.demon.co.uk ([194.70.145.210]:9253 "EHLO
	orlando.wolfsonmicro.main") by vger.kernel.org with ESMTP
	id S1750981AbWHIQvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:51:12 -0400
Subject: Re: [Alsa-devel] ALSA problems with 2.6.18-rc3
From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Benton <b3nt@ukonline.co.uk>, Takashi Iwai <tiwai@suse.de>,
       alsa-devel <alsa-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1155141333.26338.186.camel@mindpipe>
References: <44D8F3E5.5020508@ukonline.co.uk>
	 <1155073853.26338.112.camel@mindpipe> <44DA0D93.2080307@ukonline.co.uk>
	 <1155141333.26338.186.camel@mindpipe>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 17:51:09 +0100
Message-Id: <1155142269.18821.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Aug 2006 16:51:27.0535 (UTC) FILETIME=[0E6133F0:01C6BBD4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 12:35 -0400, Lee Revell wrote:
> On Wed, 2006-08-09 at 17:30 +0100, Andrew Benton wrote:
> > Lee Revell wrote:
> > > Please try to identify the change that introduced the regression.  What
> > > was the last kernel/ALSA version that worked correctly?
> > 
> > The change happened between 2.6.17 and 2.6.18-rc1. Specifically, 
> > 2.6.17-git4 works and 2.6.17-git5 doesn't.
> 
> Takashi-san,
> 
> Does this help at all?  Many users are reporting that sound broke with
> 2.6.18-rc*.

Fwiw, 2.6.18-rc1 works on arm (pxa2xx). Maybe this is related to another
subsystem not found on arm.

Liam


