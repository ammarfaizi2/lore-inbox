Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161230AbWJRQgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161230AbWJRQgU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161229AbWJRQgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:36:20 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:19090 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161228AbWJRQgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:36:18 -0400
Subject: Re: 2.6.18 w/ GPS time source: worse performance
From: Lee Revell <rlrevell@joe-job.com>
To: Udo van den Heuvel <udovdh@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45364631.9070805@xs4all.nl>
References: <4534F5F7.8020003@xs4all.nl> <1161103616.2919.70.camel@mindpipe>
	 <45364631.9070805@xs4all.nl>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 12:36:23 -0400
Message-Id: <1161189384.15860.85.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-18 at 17:20 +0200, Udo van den Heuvel wrote:
> Lee Revell wrote:
> > On Tue, 2006-10-17 at 17:25 +0200, Udo van den Heuvel wrote:
> >>
> >> Why does a GPS as time source (with ntpd) perform so much worse with 2.6.18?
> > 
> > Um... you don't give nearly enough information to even begin to know
> > what you're talking about.
> 
> No one here with a vague idea about the cause for the bad performance?
> I am sure I not the only one experiencing this.

No, the issue is that a one-sentence bug report is not helpful.  You
don't give enough information to debug it.  Kernel config, steps to
reproduce, etc, etc.

Please look at LKML archives for some examples of the type of bug report
that does get a response.

Lee

