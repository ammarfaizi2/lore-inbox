Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269987AbUJHO1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269987AbUJHO1V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 10:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269991AbUJHO1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 10:27:21 -0400
Received: from mx1.elte.hu ([157.181.1.137]:31179 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269987AbUJHO1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 10:27:09 -0400
Date: Fri, 8 Oct 2004 16:28:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
Message-ID: <20041008142826.GA20766@elte.hu>
References: <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu> <20041007105230.GA17411@elte.hu> <4165832E.1010401@cybsft.com> <4165A729.5060402@cybsft.com> <20041007215546.GA8541@elte.hu> <4165F050.5050904@cybsft.com> <20041008070252.GA30823@elte.hu> <41669E2D.6060705@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41669E2D.6060705@cybsft.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> First let me say that, in case you haven't been following the other
> thread about this "2.6.9-rc3-mm3 fails to detect aic7xxx", I resolved
> this by backing out the bk-scsi.patch and bk-scsi-target.patch.
> Without those everything works fine.

> >could you send me the following info:
> >
> >  - full log of a failed boot
> 
> I would like to be able to be able to send you this, but it doesn't
> get to the point of logging. [...]

meanwhile i could reproduce an aic79xx detection problem on a
testsystem, so no need to send the log.

	Ingo
