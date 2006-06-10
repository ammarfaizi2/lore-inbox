Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030408AbWFJRmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbWFJRmY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 13:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030457AbWFJRmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 13:42:24 -0400
Received: from mail.gmx.de ([213.165.64.21]:32694 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030408AbWFJRmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 13:42:23 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: 2.6.16-rc6-mm2
Date: Sat, 10 Jun 2006 19:42:48 +0200
User-Agent: KMail/1.9.3
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060609214024.2f7dd72c.akpm@osdl.org> <200606101818.34952.dominik.karall@gmx.net> <6bffcb0e0606100925s2577fb25he22bd4ee086a6234@mail.gmail.com>
In-Reply-To: <6bffcb0e0606100925s2577fb25he22bd4ee086a6234@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606101942.48968.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 10. June 2006 18:25, Michal Piotrowski wrote:
> On 10/06/06, Dominik Karall <dominik.karall@gmx.net> wrote:
> > On Saturday, 10. June 2006 06:40, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2
> > >.6.1 7-rc6/2.6.17-rc6-mm2/
> >
> > Hi Andrew!
> >
> > 2.6.17-rc6-mm2 and -mm1 don't boot on my amd64 machine. When I
> > select the kernel in grub my computer reboots.
> >
> > config, cpuinfo and lspci can be found at:
> > http://stud4.tuwien.ac.at/~e0227135/kernel/
>
> Please try to disable SMP and PREEMPT.

Thanks! 2.6.17-rc6-mm2 boots fine withouth SMP and PREEMPT.

thx,
dominik
