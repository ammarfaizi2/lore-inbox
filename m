Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282941AbRLXFh2>; Mon, 24 Dec 2001 00:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283586AbRLXFhS>; Mon, 24 Dec 2001 00:37:18 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:40716 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S282941AbRLXFhF>; Mon, 24 Dec 2001 00:37:05 -0500
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Cerberus testing of 2.4.17-rc1
Date: Sun, 23 Dec 2001 21:37:48 -0800
Message-ID: <HBEHIIBBKKNOBLMPKCBBCEJPEEAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <3C1E19E7.88C62DAC@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has this been fixed?
--
M. Edward Borasky
znmeb@borasky-research.net
http://www.borasky-research.net

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Bob Matthews
> Sent: Monday, December 17, 2001 8:15 AM
> To: Marcelo Tosatti; linux-kernel@vger.kernel.org
> Subject: Re: Cerberus testing of 2.4.17-rc1
>
>
> Bob Matthews wrote:
>
> > Hardware:  8 x PIII, 16G RAM, 20G Swap, 2 x Sym53c899.
> > Kernel: 2.4.17-rc1, configured with SMP, HIGHMEM=64G, plus necessary
> > drivers.
> >
> > After 10-30 minutes of testing (it's different each time) the machine
> > starts to slow down.  Eventually, the machine appears to stall
> > completely.  The timer for the test harness continues to tick, and I can
> > change virtual consoles, so the machine is not completely hung.  When
> > the machine gets into this state, the test suite stops making progress.
> > Also, input typed to the virtual consoles is not echoed.
> >
> > <SysRq><P> <T> and <M> print only the column headings, but not any data,
> > so that is as complete a bug report as I can give you at this time.
>
> The machine never made any more observable progress, and eventually
> oopsed after approx. 48 hours.

