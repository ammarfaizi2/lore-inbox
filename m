Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267520AbUHJQm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267520AbUHJQm4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267550AbUHJQlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:41:44 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:19181 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267520AbUHJQJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:09:42 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1092150252.16885.28.camel@localhost.localdomain>
References: <1092082920.5761.266.camel@cube>
	 <cone.1092092365.461905.29067.502@pc.kolivas.org>
	 <1092099669.5759.283.camel@cube>  <yw1xisbrflws.fsf@kth.se>
	 <1092148392.5818.6.camel@mindpipe>
	 <1092150252.16885.28.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1092154198.10794.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 12:09:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 11:04, Alan Cox wrote:
> On Maw, 2004-08-10 at 15:33, Lee Revell wrote:
> > I hate to derail a good flame-fest, but this would be extremely useful,
> > for more than burning CDs.  Anytime you are dealing with a SCHED_FIFO
> > process a bug can lock the machine, this would be useful for hacking
> > jackd for example.
> > 
> > If someone wants to code this up I and the other people on jackit-devel
> > would gladly test it.
> 
> How much is this actually needed and how much is it just a user
> debugging method problem. Having done real time stuff on VMS (save
> the tears) we always had a policy that one serial console was a shell
> at highest priority and nobody ever used that one top priority.
> 
> That gave you an emergency control channel.

Yeah, I haven't yet been in a situation where I needed this, it would be
useful only in theory.  It sounded like someone was volunteering to code
it up.

Lee

