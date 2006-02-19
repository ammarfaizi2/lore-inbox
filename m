Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWBSXX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWBSXX0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 18:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWBSXX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 18:23:26 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:25103 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932283AbWBSXXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 18:23:25 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: No sound from SB live!
Date: Sun, 19 Feb 2006 23:23:08 +0000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Nick Warne <nick@linicks.net>, Jesper Juhl <jesper.juhl@gmail.com>,
       tiwai@suse.de, ghrt@dial.kappa.ro, perex@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>
References: <20060218231419.GA3219@elf.ucw.cz> <20060219214702.GM15311@elf.ucw.cz> <1140385837.2733.394.camel@mindpipe>
In-Reply-To: <1140385837.2733.394.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602192323.08169.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 February 2006 21:50, Lee Revell wrote:
> On Sun, 2006-02-19 at 22:47 +0100, Pavel Machek wrote:
> > On Ne 19-02-06 16:30:37, Lee Revell wrote:
> > > On Sun, 2006-02-19 at 12:51 -0800, Nishanth Aravamudan wrote:
> > > > I run Ubuntu Breezy, which has:
> > > >
> > > > alsa-utils = 1.0.9a-4ubuntu5
> > >
> > > The alsa-utils version should not matter, it's alsa-lib that must be
> > > kept in sync with the ALSA version in the kernel.
> >
> > Ugh, not a good news.
>
> This has been the case for ages (distros still get it wrong).  It is not
> an ideal situation.
>
> >  How do I tell if my alsa libs are recent enough?
>
> 1.0.10 should be OK

I'm still using 1.0.9 on 2.6.16-rc4 with no problems, Audigy 2 (one that uses 
emu10k1).

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
