Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264062AbTEWM6y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 08:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbTEWM6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 08:58:54 -0400
Received: from mail.ithnet.com ([217.64.64.8]:11791 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S264062AbTEWM6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 08:58:52 -0400
Date: Fri, 23 May 2003 15:11:34 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: willy@w.ods.org, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
Message-Id: <20030523151134.517c06b6.skraw@ithnet.com>
In-Reply-To: <428570000.1053694721@aslan.scsiguy.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<20030509145738.GB17581@alpha.home.local>
	<20030512110218.4bbc1afe.skraw@ithnet.com>
	<20030523123837.6521738f.skraw@ithnet.com>
	<428570000.1053694721@aslan.scsiguy.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 May 2003 06:58:41 -0600
"Justin T. Gibbs" <gibbs@scsiguy.com> wrote:

> > Ok. I managed to crash the tested machine after 14 days now. The crash
> > itself is exactly like former 2.4.21-X. It just freezes, no oops no
> > nothing. It looks like things got better, but not solved.
> 
> What is telling you that the freeze is SCSI related?  Are you running
> with the nmi watchdog and have a trace?  Do you have driver messages
> that you aren't sharing?

Hello Justin,

to make that clear: I am in no way sure _what_ is causing the problem. I am
only updating the (very few) infos I gave/could give during the last weeks.
>From looking at the ongoings I would say your driver patch (URL already sent
several times) made things better. This does obviously not mean that the
kernel-included aic-driver is the sole cause of the troubles.

I am in fact very pleased that rc2/aic-20030502 made things quite noticably
better than every 21-rc/pre before.

What I am giving is a positive feedback, but I have as few logs for it as I had
for the very negative I sent times ago.

Anyway, I am continuing with stress-tests on rc3/aic-20030520. 

Regards,
Stephan
