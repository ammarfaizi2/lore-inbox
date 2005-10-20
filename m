Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751767AbVJTGOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbVJTGOh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 02:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbVJTGOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 02:14:37 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:12935 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751767AbVJTGOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 02:14:36 -0400
Date: Thu, 20 Oct 2005 08:15:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark Knecht <markknecht@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org
Subject: Re: -rt10 build problem [WAS]Re: scsi_eh / 1394 bug - -rt7
Message-ID: <20051020061502.GA26753@elte.hu>
References: <5bdc1c8b0510190750s377a2696kf9c323789b392664@mail.gmail.com> <20051019145435.GA6455@elte.hu> <5bdc1c8b0510190812l6b9574cft14664fa40f1225ce@mail.gmail.com> <20051019193854.GA12908@elte.hu> <5bdc1c8b0510191310g3fa73535hebe5f45e55875aba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bdc1c8b0510191310g3fa73535hebe5f45e55875aba@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Knecht <markknecht@gmail.com> wrote:

> On 10/19/05, Ingo Molnar <mingo@elte.hu> wrote:
> >
> > * Mark Knecht <markknecht@gmail.com> wrote:
> >
> > > Sorry. Please resend the patch as a file. My trying to copy it from
> > > GMail has apparently killed it:
> >
> > just pick up -rt11.
> >
> >         Ingo
> >
> 
> Thanks Ingo. Sorry for being such a putz! ;-)

nah, browsers can be a PITA when it comes to saving plaintext patches.

> 2.6.14-rc4-rt11 is up and running. No SCSI errors. No xruns as of yet.

great!

	Ingo
