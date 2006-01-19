Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbWASSjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbWASSjI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 13:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWASSjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 13:39:08 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:15758 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030318AbWASSjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 13:39:07 -0500
Subject: Re: RFC: OSS driver removal, a slightly different approach
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
In-Reply-To: <20060119182859.GW19398@stusta.de>
References: <20060119174600.GT19398@stusta.de>
	 <1137694944.32195.1.camel@mindpipe>  <20060119182859.GW19398@stusta.de>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 13:39:04 -0500
Message-Id: <1137695945.32195.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 19:28 +0100, Adrian Bunk wrote:
> On Thu, Jan 19, 2006 at 01:22:23PM -0500, Lee Revell wrote:
> > On Thu, 2006-01-19 at 18:46 +0100, Adrian Bunk wrote:
> > > 3. no ALSA drivers for the same hardware
> > > 
> > > SOUND_SB 
> > 
> > ALSA certainly does support "100% Sound Blaster compatibles (SB16/32/64,
> > ESS, Jazz16)", it would be a joke if it didn't...
> 
> That's not the problem, I should have added an explanation:
> 
> SOUND_SB (due to SOUND_KAHLUA and SOUND_PAS)

Are there any other cases like that?  Maybe you could indent the list to
clearly show the relationship?

Lee

