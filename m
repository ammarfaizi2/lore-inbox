Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWAMPgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWAMPgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWAMPgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:36:37 -0500
Received: from mtaout2.012.net.il ([84.95.2.4]:14494 "EHLO mtaout2.012.net.il")
	by vger.kernel.org with ESMTP id S964835AbWAMPgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:36:37 -0500
Date: Fri, 13 Jan 2006 17:36:29 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH] Prevent trident driver from grabbing pcnet32 hardware
In-reply-to: <20060113152421.GP29663@stusta.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Jon Mason <jdmason@us.ibm.com>,
       Jiri Slaby <slaby@liberouter.org>, linux-kernel@vger.kernel.org
Message-id: <20060113153628.GB19429@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060112175051.GA17539@us.ibm.com>
 <43C6ADDE.5060904@liberouter.org> <20060112200735.GD5399@granada.merseine.nu>
 <20060112214719.GE17539@us.ibm.com> <20060112220039.GX29663@stusta.de>
 <1137105731.2370.94.camel@mindpipe>
 <20060113113756.GL5399@granada.merseine.nu> <20060113122358.GH29663@stusta.de>
 <20060113123215.GQ5399@granada.merseine.nu> <20060113152421.GP29663@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 04:24:21PM +0100, Adrian Bunk wrote:

> Either the ALSA driver is better in any respect making the OSS driver 
> simply obsolete, or there are problems in the ALSA driver that should be 
> reported and fixed.
> 
> Removing the OSS driver forces users to report the problems with the 
> ALSA driver making the latter better for everyone.

Yeah, and rm -rf'ing ftp.kernel.org is a great way to make everyone
write a better operating system. Surely there's a less destructive way
to do things.

In any case, I think this thread has run its course and we can agree
to disagree now.

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

