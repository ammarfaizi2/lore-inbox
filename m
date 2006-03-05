Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751795AbWCEVnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbWCEVnI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 16:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751835AbWCEVnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 16:43:08 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:64141 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751846AbWCEVnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 16:43:06 -0500
Subject: Re: [OT] inotify hack for locate
From: Lee Revell <rlrevell@joe-job.com>
To: jonathan@jonmasters.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com>
References: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 05 Mar 2006 16:43:03 -0500
Message-Id: <1141594983.14714.121.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-05 at 21:36 +0000, Jon Masters wrote:
> Folks,
> 
> I'm fed up with those finds running whenever I power on. Has anyone
> written an equivalent of the Microsoft indexing service to update
> locate's database?
> 
> I know about Beagle and friends but I'd be interested in whatever I'm
> missing that specifically solves the above problem - I'm sure it's
> been done :-)

updatedb runs at nice 20 on most distros, and with the CFQ scheduler the
IO priority follows the nice value, so why does it still kill the
machine?

Lee

