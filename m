Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965564AbWFYUBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965564AbWFYUBA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 16:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965562AbWFYUA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 16:00:59 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:44716 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S965559AbWFYUA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 16:00:58 -0400
Subject: Re: I can cause kernel panic by using native alsa midi with
	2.6.17.1
From: Lee Revell <rlrevell@joe-job.com>
To: Dave Jones <davej@redhat.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Knut J Bjuland <knutjbj@online.no>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060625063151.GE26273@redhat.com>
References: <200606250207_MC3-1-C35F-F5F8@compuserve.com>
	 <20060625063151.GE26273@redhat.com>
Content-Type: text/plain
Date: Sun, 25 Jun 2006 16:00:53 -0400
Message-Id: <1151265654.2931.256.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-25 at 02:31 -0400, Dave Jones wrote:
> On Sun, Jun 25, 2006 at 02:03:21AM -0400, Chuck Ebbert wrote:
>  > In-Reply-To: <449B8A0D.60607@online.no>
>  > 
>  > On Fri, 23 Jun 2006 08:28:29 +0200, Knut J Bjuland wrote:
>  > 
>  > > ksymoops 2.4.9 on i686 2.6.17-1.2138_FC5smp.  Options used
>  > 
>  > Please do not run oops reports through ksymoops.  The recipient
>  > can do that.  And report Fedora bugs to Fedora...
> 
> It's already in Fedora bugzilla. It matches the same thing I reported
> here a few days ago. With a list-head debug patch (kinda sorta
> the same as the one in -mm), alsa goes boom.

I have not seen a bug report in the ALSA bug tracker or a report on
alsa-devel.

Lee

