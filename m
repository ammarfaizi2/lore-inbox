Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWFTSf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWFTSf2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 14:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWFTSf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 14:35:28 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:12228 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750792AbWFTSf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 14:35:28 -0400
Subject: Re: sound skips on 2.6.16.17
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: ocilent1@gmail.com, Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       Hugo Vanwoerkom <rociobarroso@att.net.mx>,
       linux list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060619215023.GA1424@tuatara.stupidest.org>
References: <4487F942.3030601@att.net.mx>
	 <200606181204.29626.ocilent1@gmail.com>
	 <20060618044047.GA1261@tuatara.stupidest.org>
	 <200606191154.33747.ocilent1@gmail.com> <1150752280.2754.38.camel@mindpipe>
	 <20060619215023.GA1424@tuatara.stupidest.org>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 14:35:29 -0400
Message-Id: <1150828530.2754.135.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-19 at 14:50 -0700, Chris Wedgwood wrote:
> On Mon, Jun 19, 2006 at 05:24:40PM -0400, Lee Revell wrote:
> 
> > Is it likely to be fixed in 2.6.17.1?
> 
> I think clearly we'll have to do something.

I see that no fix made it into 2.6.17.1 or 2.6.16.22.

What is the downside of simply reverting the patch that introduced the
regression?

Lee 

