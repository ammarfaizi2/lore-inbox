Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271839AbTGRPGu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271831AbTGRPDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:03:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:4844 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272740AbTGROXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:23:07 -0400
Date: Fri, 18 Jul 2003 07:35:36 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.72 insmod question
Message-Id: <20030718073536.5e60cc3d.rddunlap@osdl.org>
In-Reply-To: <20030718115045.GW8160@louise.pinerecords.com>
References: <334DD5C2ADAB9245B60F213F49C5EBCD05D55212@axcs03.cos.agilent.com>
	<1173.4.4.25.4.1058489266.squirrel@www.osdl.org>
	<20030718115045.GW8160@louise.pinerecords.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jul 2003 13:50:45 +0200 Tomas Szepe <szepe@pinerecords.com> wrote:

| > [rddunlap@osdl.org]
| > 
| > And you probably should read over the 2.6 migration document:
| >   http://www.codemonkey.org.uk/post-halloween-2.5.txt
| 
| Wouldn't it be a good idea to print a similar note during
| "make *config" in the 2.6.0-test series?  I mean, this must
| be the 80th or so post of its kind this week.

Sure, that sounds good to me.  Some way to get that message to
the masses, since putting it in an email signature doesn't get
the message to the right people... :(

--
~Randy
For Linux-2.6:
http://www.codemonkey.org.uk/post-halloween-2.5.txt
  or http://lwn.net/Articles/39901/
http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
