Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262663AbREOHvD>; Tue, 15 May 2001 03:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262666AbREOHux>; Tue, 15 May 2001 03:50:53 -0400
Received: from cr481834-a.ktchnr1.on.wave.home.com ([24.102.89.11]:63205 "HELO
	scotch.homeip.net") by vger.kernel.org with SMTP id <S262663AbREOHuo>;
	Tue, 15 May 2001 03:50:44 -0400
Date: Tue, 15 May 2001 03:50:31 -0400 (EDT)
From: God <atm@sdk.ca>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: TCP capture effect :: estimate queue length ? :: pathchar
In-Reply-To: <20010515030645.A15896@bacchus.dhis.org>
Message-ID: <Pine.LNX.4.21.0105150348000.23642-100000@scotch.homeip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2001, Ralf Baechle wrote:

> On Mon, May 14, 2001 at 11:49:16PM -0400, God wrote:
> 
> > Speaking of queues on routers/servers, does such a util exist that would
> > measure (even a rough estimate), what level of congestion (queueing) is
> > happening between point A and B ?  I'd be curious how badly congested some
> > things upstream from me are......   I know I can use ping or
> > traceroute ... but they don't report queueing or bursting.  Both measure
> > latency and packetloss ... short of stareing at a running ping that is
> > ... <G>
> 
> Pathchar, yet another Van Jacobsen toy does this.  Unfortunately the old
> and rotten pre-version you can find in ftp.ee.lbl.gov:/pathchar/ is afaik
> the last one.  In the past it served me well you find about how ISPs are
> lying ...  100mbit backbone = fast ethernet in their computer room ...
> 


pathchar (last I used it), doesn't report queueing or bursting levels.  It
is purely a bandwidth estimator (and a dam fine one too!) ...  Could be
wrong though, I just don't recall seeing that as feature.



