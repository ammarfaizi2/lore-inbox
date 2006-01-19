Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161302AbWASWDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161302AbWASWDM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161315AbWASWDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:03:11 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:39175 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1161302AbWASWDK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:03:10 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: RFC: OSS driver removal, a slightly different approach
Date: Thu, 19 Jan 2006 22:03:10 +0000
User-Agent: KMail/1.9
Cc: =?iso-8859-1?q?Fr=E9d=E9ric?= "L. W. Meunier" <2@pervalidus.net>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       perrye@linuxmail.org
References: <20060119174600.GT19398@stusta.de> <Pine.LNX.4.64.0601191815550.1300@dyndns.pervalidus.net> <1137703548.32195.25.camel@mindpipe>
In-Reply-To: <1137703548.32195.25.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601192203.11032.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 January 2006 20:45, Lee Revell wrote:
> On Thu, 2006-01-19 at 18:22 -0200, Frédéric L. W. Meunier wrote:
> > On Thu, 19 Jan 2006, Adrian Bunk wrote:
> > > 3. no ALSA drivers for the same hardware
> >
> > Why aren't drivers like SOUND_TVMIXER listed ? That one isn't
> > in ALSA, but there's a port at
> > http://www.gilfillan.org/v3tv/ALSA/ . It's now the only I
> > enable in OSS.
>
> Grr... why would someone bother to write a driver then not submit it or
> even tell the ALSA maintainers?

The code looks to be in pretty decent shape too. With minor changes it could 
easily get into the kernel.

Maybe somebody should contact the maintainer (added to CC).

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
