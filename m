Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWBZVfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWBZVfM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 16:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWBZVfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 16:35:11 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:18615 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751410AbWBZVfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 16:35:10 -0500
Subject: Re: old radeon latency problem still unfixed?
From: Lee Revell <rlrevell@joe-job.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>
In-Reply-To: <21d7e9970602261331n128d50f3g55af85d7c8c27f93@mail.gmail.com>
References: <1140917787.24141.78.camel@mindpipe>
	 <20060226014437.327b1cc3.akpm@osdl.org>
	 <1140947860.2934.12.camel@laptopd505.fenrus.org>
	 <1140982763.24141.123.camel@mindpipe>
	 <21d7e9970602261331n128d50f3g55af85d7c8c27f93@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 16:35:03 -0500
Message-Id: <1140989703.24141.164.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 08:31 +1100, Dave Airlie wrote:
> >
> > Thanks I will check on this.
> >
> 
> I don't suppose they are running with X renice -10?
> 
> or some such.. that was done by a few vendors previously.. if X is
> using hw accel, then it will be in the DRM driver a bit...

Radeon uses DRI for regular 2D XAA acceleration?  That's good to know.

This is not very common right?

Lee

