Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262969AbVAFV2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbVAFV2p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 16:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbVAFV11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 16:27:27 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:50605 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S263028AbVAFVYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 16:24:35 -0500
Date: Thu, 6 Jan 2005 16:24:31 -0500
To: Lee Revell <rlrevell@joe-job.com>
Cc: Norbert van Nobelen <Norbert@edusupport.nl>,
       Raphael Jacquot <raphael.jacquot@imag.fr>, linux-kernel@vger.kernel.org
Subject: Re: Open hardware wireless cards
Message-ID: <20050106212431.GD30311@csclub.uwaterloo.ca>
References: <20050105200526.GL5159@ruslug.rutgers.edu> <20050106172438.GT5159@ruslug.rutgers.edu> <41DD8D71.7000708@imag.fr> <200501062032.13513.Norbert@edusupport.nl> <1105045205.15823.4.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105045205.15823.4.camel@krustophenia.net>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 04:00:05PM -0500, Lee Revell wrote:
> On Thu, 2005-01-06 at 20:32 +0100, Norbert van Nobelen wrote:
> > 100mWatt antenna (-: Gives 4 mile range (-:
> > Make it USB powered (-: (so that the pcmcia card does not overheat!!)
> 
> Ah, this reminds me, isn't there some kind of issue with open source
> wireless and FCC (or whatever your local equivalent is) regulations?  Or
> was that just an excuse the vendors used for their closed source
> drivers?

Just an excuse.

Someone determined enough would hex edit the code to change the signal
power.  The FCC isn't stupid enough to believe obfuscation prevents
abuse.  They just have laws against using too high a power.  Of course
enforcing it isn't easy either.  And the firmware can't prevent you from
changing the antenna and/or using a signal booster.

Len Sorensen
