Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWHVRj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWHVRj4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 13:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWHVRj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 13:39:56 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:29853 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751417AbWHVRjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 13:39:54 -0400
Date: Tue, 22 Aug 2006 19:37:22 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Denis Vlasenko <vda.linux@googlemail.com>
cc: Lee Revell <rlrevell@joe-job.com>, Eric Piel <Eric.Piel@tremplin-utc.net>,
       mplayer-users@mplayerhq.hu, linux-kernel@vger.kernel.org
Subject: Re: mplayer + heavy io: why ionice doesn't help?
In-Reply-To: <200608221826.08802.vda.linux@googlemail.com>
Message-ID: <Pine.LNX.4.61.0608221936010.14463@yvahk01.tjqt.qr>
References: <200608181937.25295.vda.linux@googlemail.com>
 <200608201843.58849.vda.linux@googlemail.com> <1156109768.10565.55.camel@mindpipe>
 <200608221826.08802.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>RT - yes, multithreaded - unsure. Witness how squid manages to
>serve hundreds of simultaneous streams using just a single process.

So apache (with the most common MPMs) is badly designed ;-)



Jan Engelhardt
-- 
