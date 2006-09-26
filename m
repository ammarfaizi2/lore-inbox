Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWIZOhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWIZOhl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 10:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWIZOhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 10:37:41 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:15563 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S932084AbWIZOhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 10:37:41 -0400
From: Dominique Dumont <domi.dumont@free.fr>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       alsa-user <alsa-user@lists.sourceforge.net>
Subject: Re: Pb with simultaneous SATA and ALSA I/O
References: <877izsp3dm.fsf@gandalf.hd.free.fr>
	<20060925143838.GQ13641@csclub.uwaterloo.ca>
	<1159195859.2899.72.camel@mindpipe>
Date: Tue, 26 Sep 2006 16:37:40 +0200
In-Reply-To: <1159195859.2899.72.camel@mindpipe> (Lee Revell's message of
	"Mon, 25 Sep 2006 10:50:59 -0400")
Message-ID: <87bqp2ofrf.fsf@gandalf.hd.free.fr>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: domi.dumont@free.fr
X-SA-Exim-Scanned: No (on gandalf.hd.free.fr); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:

> Dominique: try the -rt kernel, enable latency tracing and post the
> output.

Should I use 2.6.17 + rt to stay closer to my current setup or should I get 2.6.18 + rt ?

Thanks
