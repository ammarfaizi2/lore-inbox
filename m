Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273296AbTHFCKL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 22:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273298AbTHFCKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 22:10:11 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:7076
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S273296AbTHFCKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 22:10:06 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Svein Ove Aas <svein.ove@aas.no>, Alex Goddard <agoddard@purdue.edu>,
       svein@brage.info
Subject: Re: 2.6.0-tst2-mm4 and ide-scsi
Date: Wed, 6 Aug 2003 12:15:02 +1000
User-Agent: KMail/1.5.3
Cc: Alexander Hoogerhuis <alexh@ihatent.com>, linux-kernel@vger.kernel.org
References: <871xw1kyu2.fsf@lapper.ihatent.com> <Pine.LNX.4.56.0308052041560.3753@dust> <200308060346.45771.svein.ove@aas.no>
In-Reply-To: <200308060346.45771.svein.ove@aas.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308061215.02861.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003 11:46, Svein Ove Aas wrote:
> onsdag 6. august 2003, 03:43, skrev Alex Goddard:
> > On Wed, 6 Aug 2003 svein@brage.info wrote:
> > > > [Snip]
> > > >
> > > > Tried burning without ide-scsi?  As long as you have a recent enough
> > > > version of cdrtools, ide-scsi is no longer necessary in 2.5/2.6.  I
> > > > haven't used ide-scsi in months, and CD burning works just fine.
> > >
> > > Well, then, what about cdrdao?
> > > I sometimes need to make more exact copies of a CD than cdrtools
> > > allows, and cdrdao doesn't seem top support IDE devices yet.
> >
> > I'm pretty much positive that cdrecord has a disk at once version that
> > doesn't make anything explode.
>
> The only one I'm aware of is the '-dao' option, but that's no good when
> what I really want to do is burn a CUE sheet and files, or copy another CD.
> It still expects an ISO file(or WAV, whatever) as input.
>
> Actualy, the only use for that option that I'm aware of is to help a few
> troubled CD-readers.

Latest version supports -dao cuefile=

please download and use that.

Con

