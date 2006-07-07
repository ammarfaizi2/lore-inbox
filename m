Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWGGSAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWGGSAF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 14:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWGGSAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 14:00:05 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:19429 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932242AbWGGSAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 14:00:02 -0400
Subject: Re: sound skips on 2.6.16.17
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: ocilent1@gmail.com, Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       Hugo Vanwoerkom <rociobarroso@att.net.mx>,
       linux list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060707170045.GA23243@tuatara.stupidest.org>
References: <200606181204.29626.ocilent1@gmail.com>
	 <20060618044047.GA1261@tuatara.stupidest.org>
	 <200606191154.33747.ocilent1@gmail.com> <1150752280.2754.38.camel@mindpipe>
	 <20060619215023.GA1424@tuatara.stupidest.org>
	 <1150828530.2754.135.camel@mindpipe>
	 <20060620193620.GA24097@tuatara.stupidest.org>
	 <1151447157.2899.137.camel@mindpipe>
	 <20060627224845.GA25315@tuatara.stupidest.org>
	 <1152289985.4736.86.camel@mindpipe>
	 <20060707170045.GA23243@tuatara.stupidest.org>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 14:00:33 -0400
Message-Id: <1152295234.4736.93.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 10:00 -0700, Chris Wedgwood wrote:
> On Fri, Jul 07, 2006 at 12:33:05PM -0400, Lee Revell wrote:
> 
> > Two more reports possibly related to this bug:
> >
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2248
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2263
> 
> One is definately affected by this.
> 
> Can we get an lspci -n from both of these if we haven't seen them
> before?

#2248 has lspci output attached already, and I requested it for #2263.

Lee

