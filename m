Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267602AbUI1G7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267602AbUI1G7h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 02:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267607AbUI1G7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 02:59:37 -0400
Received: from scanner1.mail.elte.hu ([157.181.1.137]:17361 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267602AbUI1G7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 02:59:36 -0400
Date: Tue, 28 Sep 2004 09:01:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Matt Heler <lkml@lpbproductions.com>
Subject: Re: 2.6.9-rc2-mm4
Message-ID: <20040928070104.GA14836@elte.hu>
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <200409270940.39851.lkml@lpbproductions.com> <20040927201709.GA19257@elte.hu> <200409272142.35182.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409272142.35182.gene.heskett@verizon.net>
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


* Gene Heskett <gene.heskett@verizon.net> wrote:

> On Monday 27 September 2004 16:17, Ingo Molnar wrote:
> >* Matt Heler <lkml@lpbproductions.com> wrote:
> >> Yup, turning opff pre-emptable bkl makes it boot up and work just
> >> fine.
> >
> >do you know which particular subsystem broke (by comparing the
> > failed and the successful bootlogs)?
> 
> How do we save the broken bootlog when the machines only response is
> to the reset key?

what i use is serial logging to another machine. A digital camera is
fine too, if the problem area is still visible on the screen. 
(Netconsole is useful too for other type of hangs but it's not active at
such an early stage yet.)

	Ingo
