Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422664AbWF0WZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422664AbWF0WZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422644AbWF0WZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:25:58 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:22505 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1422664AbWF0WZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:25:56 -0400
Subject: Re: sound skips on 2.6.16.17
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: ocilent1@gmail.com, Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       Hugo Vanwoerkom <rociobarroso@att.net.mx>,
       linux list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060620193620.GA24097@tuatara.stupidest.org>
References: <4487F942.3030601@att.net.mx>
	 <200606181204.29626.ocilent1@gmail.com>
	 <20060618044047.GA1261@tuatara.stupidest.org>
	 <200606191154.33747.ocilent1@gmail.com> <1150752280.2754.38.camel@mindpipe>
	 <20060619215023.GA1424@tuatara.stupidest.org>
	 <1150828530.2754.135.camel@mindpipe>
	 <20060620193620.GA24097@tuatara.stupidest.org>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 18:25:56 -0400
Message-Id: <1151447157.2899.137.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 12:36 -0700, Chris Wedgwood wrote:
> On Tue, Jun 20, 2006 at 02:35:29PM -0400, Lee Revell wrote:
> 
> > I see that no fix made it into 2.6.17.1 or 2.6.16.22.
> 
> both came out very quickly and i was waiting on the results from a
> couple of people
> 
> > What is the downside of simply reverting the patch that introduced the
> > regression?
> 
> it breaks for some other people, it's not clear what the 'right' fix
> here should be, but it might end up being the lesser of two evils
> 
> it would be *really* nice if someone from VIA could weigh in here

Any progress on this?  I don't see a fix in 2.6.17.2.

Lee

