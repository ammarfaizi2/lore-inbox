Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWIZOo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWIZOo3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 10:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWIZOo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 10:44:29 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:20352 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932093AbWIZOo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 10:44:28 -0400
Subject: Re: Pb with simultaneous SATA and ALSA I/O
From: Lee Revell <rlrevell@joe-job.com>
To: Dominique Dumont <domi.dumont@free.fr>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       alsa-user <alsa-user@lists.sourceforge.net>
In-Reply-To: <87bqp2ofrf.fsf@gandalf.hd.free.fr>
References: <877izsp3dm.fsf@gandalf.hd.free.fr>
	 <20060925143838.GQ13641@csclub.uwaterloo.ca>
	 <1159195859.2899.72.camel@mindpipe>  <87bqp2ofrf.fsf@gandalf.hd.free.fr>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 10:44:56 -0400
Message-Id: <1159281897.2899.188.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-26 at 16:37 +0200, Dominique Dumont wrote:
> Lee Revell <rlrevell@joe-job.com> writes:
> 
> > Dominique: try the -rt kernel, enable latency tracing and post the
> > output.
> 
> Should I use 2.6.17 + rt to stay closer to my current setup or should I get 2.6.18 + rt ?
> 

I would say 2.6.18 + -rt - it's not as if 2.6.17 could be fixed at this
point.

Lee

