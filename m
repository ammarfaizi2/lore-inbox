Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbTELIts (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 04:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbTELIts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 04:49:48 -0400
Received: from mail.ithnet.com ([217.64.64.8]:772 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S262008AbTELItr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 04:49:47 -0400
Date: Mon, 12 May 2003 11:02:18 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: willy@w.ods.org, gibbs@scsiguy.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
Message-Id: <20030512110218.4bbc1afe.skraw@ithnet.com>
In-Reply-To: <20030509145738.GB17581@alpha.home.local>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<20030509145738.GB17581@alpha.home.local>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 May 2003 16:57:38 +0200
Willy Tarreau <willy@w.ods.org> wrote:

> On Fri, May 09, 2003 at 04:11:06PM +0200, Stephan von Krawczynski wrote:
> > On Fri, 9 May 2003 15:27:57 +0200
> > Willy Tarreau <willy@w.ods.org> wrote:
> > 
> > > Well, would you at least agree to retest current version from the above
> > > URL ? I find it a bit of a shame that the driver goes back in -rc stage.
> > 
> > Ok, I can tell you at least this: it boots. Just did it. I can tell
> > tomorrow how it behaves with my specific problem.
> 
> Thanks for having tried ;-)

Hello all,

I have tried 2.4.21-rc2 with aic79xx-linux-2.4-20030502-tar.gz for three days
now and have to say it performs well. I had no freezes any more and nothing
weird happening. Everything is smooth and ok. This is the best performance I
have seen comparing all 2.4.21-X versions tested.

Thanks a lot.

I will proceed with further stress tests...

Regards,
Stephan
