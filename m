Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422704AbWF0Wst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422704AbWF0Wst (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422707AbWF0Wst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:48:49 -0400
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:43700 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422704AbWF0Wsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:48:46 -0400
Date: Tue, 27 Jun 2006 15:48:45 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: ocilent1@gmail.com, Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       Hugo Vanwoerkom <rociobarroso@att.net.mx>,
       linux list <linux-kernel@vger.kernel.org>
Subject: Re: sound skips on 2.6.16.17
Message-ID: <20060627224845.GA25315@tuatara.stupidest.org>
References: <4487F942.3030601@att.net.mx> <200606181204.29626.ocilent1@gmail.com> <20060618044047.GA1261@tuatara.stupidest.org> <200606191154.33747.ocilent1@gmail.com> <1150752280.2754.38.camel@mindpipe> <20060619215023.GA1424@tuatara.stupidest.org> <1150828530.2754.135.camel@mindpipe> <20060620193620.GA24097@tuatara.stupidest.org> <1151447157.2899.137.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151447157.2899.137.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 06:25:56PM -0400, Lee Revell wrote:

> Any progress on this?  I don't see a fix in 2.6.17.2.

i'm still trying to get details on why ACPI suffices for some people
but not all

i'm hoping to avoid something gross like a whitelist where we avoid
the quirk and do it otherwise but that might be the best option right
now
