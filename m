Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVDSTRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVDSTRH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 15:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVDSTRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 15:17:07 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:36551 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261596AbVDSTRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 15:17:02 -0400
Subject: Re: /proc/cpuinfo format - arch dependent!
From: Lee Revell <rlrevell@joe-job.com>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050419132417.GS17865@csclub.uwaterloo.ca>
References: <20050419121530.GB23282@schottelius.org>
	 <20050419132417.GS17865@csclub.uwaterloo.ca>
Content-Type: text/plain
Date: Tue, 19 Apr 2005 15:17:00 -0400
Message-Id: <1113938220.20178.0.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-19 at 09:24 -0400, Lennart Sorensen wrote:
> On Tue, Apr 19, 2005 at 02:15:30PM +0200, Nico Schottelius wrote:
> > When I wrote schwanz3(*) for fun, I noticed /proc/cpuinfo
> > varies very much on different architectures.
> > 
> > Is it possible to make it look more identical (as far as the different
> > archs allow it)?
> > 
> > So that one at least can count the cpus on every system the same way.
> > 
> > If so, who would the one I should contact and who would accept / verify
> > a patch doing that?
> 
> If you change it now, how many tools would break?
> 

Lots.  Please don't change the format of /proc/cpuinfo.

Lee

