Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbTKHAAe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 19:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbTKGX6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 18:58:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:63926 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261776AbTKGXzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 18:55:38 -0500
Date: Fri, 7 Nov 2003 15:51:47 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Beau E. Cox" <beau@beaucox.com>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.23-pre7,pre8,pre9 hang on starting squid
Message-Id: <20031107155147.05671d94.rddunlap@osdl.org>
In-Reply-To: <200311070600.02069.beau@beaucox.com>
References: <Pine.LNX.4.44.0311061204510.8534-100000@logos.cnet>
	<200311070600.02069.beau@beaucox.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Nov 2003 06:00:01 -1000 "Beau E. Cox" <beau@beaucox.com> wrote:

| On Thursday 06 November 2003 04:06 am, Marcelo Tosatti wrote:
| > On Mon, 3 Nov 2003, Beau E. Cox wrote:
| > > [1.] summary:
| > >
| > > 2.4.23-pre7,pre8,pre9 hang depending on when 'squid' is started.
| > >
| > > [snipped]
| >
| > Strange.
| >
| > Can you find out in which -pre the problem starts?
| >
| 
| Hi - I want to track down the 'pre' where my problem started (I would
| need 2.4.23-pre1 thru pre6), but I can't find them anywhere on the
| kernel archaive site (mirros too). Where can I get these pre patches?


They are in this directory:
  http://www.kernel.org/pub/linux/kernel/v2.4/testing/

--
~Randy
MOTD:  Always include version info.
