Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWFTTge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWFTTge (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 15:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWFTTge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 15:36:34 -0400
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:19318 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750812AbWFTTgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 15:36:33 -0400
Date: Tue, 20 Jun 2006 12:36:20 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: ocilent1@gmail.com, Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       Hugo Vanwoerkom <rociobarroso@att.net.mx>,
       linux list <linux-kernel@vger.kernel.org>
Subject: Re: sound skips on 2.6.16.17
Message-ID: <20060620193620.GA24097@tuatara.stupidest.org>
References: <4487F942.3030601@att.net.mx> <200606181204.29626.ocilent1@gmail.com> <20060618044047.GA1261@tuatara.stupidest.org> <200606191154.33747.ocilent1@gmail.com> <1150752280.2754.38.camel@mindpipe> <20060619215023.GA1424@tuatara.stupidest.org> <1150828530.2754.135.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150828530.2754.135.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 02:35:29PM -0400, Lee Revell wrote:

> I see that no fix made it into 2.6.17.1 or 2.6.16.22.

both came out very quickly and i was waiting on the results from a
couple of people

> What is the downside of simply reverting the patch that introduced the
> regression?

it breaks for some other people, it's not clear what the 'right' fix
here should be, but it might end up being the lesser of two evils

it would be *really* nice if someone from VIA could weigh in here
