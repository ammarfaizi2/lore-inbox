Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWJLUgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWJLUgh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 16:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWJLUgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 16:36:37 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:2471 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750815AbWJLUgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 16:36:36 -0400
Subject: Re: Userspace process may be able to DoS kernel
From: Lee Revell <rlrevell@joe-job.com>
To: =?ISO-8859-1?Q?G=FCnther?= Starnberger <gst@sysfrog.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <474c7c2f0610121330x10f1148epb37c1acb7ceb762c@mail.gmail.com>
References: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com>
	 <1160668290.24931.31.camel@mindpipe>
	 <474c7c2f0610121330x10f1148epb37c1acb7ceb762c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 12 Oct 2006 16:37:32 -0400
Message-Id: <1160685453.24931.86.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 16:30 -0400, Günther Starnberger wrote:
> On 10/12/06, Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Do you get the same behavior using the old OSS drivers that you get with
> > ALSA's OSS emulation?
> 
> Yes. I've rmmod'ed ALSA and used the i810_audio OSS module instead.
> Same problem.

OK, so the sound subsystem has been ruled out.  That just leaves...
everything else ;-)

Lee

