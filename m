Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWCGTPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWCGTPI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 14:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWCGTPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 14:15:08 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:25045 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751296AbWCGTPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 14:15:06 -0500
Subject: Re: [Alsa-user] arecord under 2.6.15.4-rt17 ->overruns...
From: Lee Revell <rlrevell@joe-job.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Sergei Steshenko <steshenko_sergei@list.ru>,
       alsa-user@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       gregkh@suse.de
In-Reply-To: <Pine.LNX.4.60.0603071955350.3662@poirot.grange>
References: <Pine.LNX.4.60.0603022032040.4969@poirot.grange>
	 <1141331113.3042.5.camel@mindpipe>
	 <Pine.LNX.4.60.0603022132160.4969@poirot.grange>
	 <1141333305.3042.14.camel@mindpipe>
	 <Pine.LNX.4.60.0603022207160.3033@poirot.grange>
	 <1141334604.3042.17.camel@mindpipe>
	 <Pine.LNX.4.60.0603022226130.3033@poirot.grange>
	 <1141335418.3042.25.camel@mindpipe>
	 <Pine.LNX.4.60.0603030012070.3397@poirot.grange>
	 <1141342018.3042.40.camel@mindpipe>
	 <Pine.LNX.4.60.0603030707270.2959@poirot.grange>
	 <1141410043.3042.116.camel@mindpipe>
	 <Pine.LNX.4.60.0603041429340.3283@poirot.grange>
	 <20060304154357.74f74cac@localhost>
	 <Pine.LNX.4.60.0603041823560.3601@poirot.grange>
	 <1141495123.3042.181.camel@mindpipe>
	 <Pine.LNX.4.60.0603042046450.3135@poirot.grange>
	 <1141509605.14714.11.camel@mindpipe>
	 <Pine.LNX.4.60.0603051915020.3204@poirot.grange>
	 <Pine.LNX.4.60.0603071851190.3662@poirot.grange>
	 <1141757284.767.56.camel@mindpipe>
	 <Pine.LNX.4.60.0603071955350.3662@poirot.grange>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 14:15:01 -0500
Message-Id: <1141758903.767.62.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-07 at 20:00 +0100, Guennadi Liakhovetski wrote:
> On Tue, 7 Mar 2006, Lee Revell wrote:
> 
> > On Tue, 2006-03-07 at 19:30 +0100, Guennadi Liakhovetski wrote:
> > 
> > > And my audio still doesn't work properly... 
> > 
> > Yes you've mentioned that several times.
> 
> Ok, sorry, I just wanted to come to some resolution - either a fix or an 
> agreement that it's unfixable. So, if there are no further ideas, I'll 
> just open an entry on bugzilla and be done with it.
> 
> Thanks for trying to help me, everyone, sorry, if I abused your help in 
> any way:-)

Does the OSS driver have the same problem?

Lee

