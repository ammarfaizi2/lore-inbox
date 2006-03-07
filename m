Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWCGSsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWCGSsI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 13:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWCGSsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 13:48:08 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:40134 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751454AbWCGSsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 13:48:07 -0500
Subject: Re: [Alsa-user] arecord under 2.6.15.4-rt17 ->overruns...
From: Lee Revell <rlrevell@joe-job.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Sergei Steshenko <steshenko_sergei@list.ru>,
       alsa-user@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       gregkh@suse.de
In-Reply-To: <Pine.LNX.4.60.0603071851190.3662@poirot.grange>
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
Content-Type: text/plain
Date: Tue, 07 Mar 2006 13:48:03 -0500
Message-Id: <1141757284.767.56.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-07 at 19:30 +0100, Guennadi Liakhovetski wrote:
> Ok, my mistake. The quirk checks the southbridge revision, but configures 
> byte 0x76 on the host (north) bridge, where it does get successfully set 
> and remains set. But it doesn't seem to help. Still, at least the comment 
> is wrong - it contradicts the code. Who is the author of that quirk? Any 
> comments whether my problem seems similar to what others observed with 
> this chipset?
> 

I doubt that issue has anything to do with your problem.

> And my audio still doesn't work properly... 

Yes you've mentioned that several times.

Lee

