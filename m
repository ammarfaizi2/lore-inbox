Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbUBWSG5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 13:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbUBWSG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 13:06:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:54989 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261872AbUBWSGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 13:06:55 -0500
Date: Mon, 23 Feb 2004 09:59:19 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: robert of northworthige <bobh@n-cantrell.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is LOADLIN still viable for 2.6?
Message-Id: <20040223095919.70ce9a10.rddunlap@osdl.org>
In-Reply-To: <NkcvILAg5jOAFwZp@n-cantrell.demon.co.uk>
References: <20040223145740.M2949@www.igotu.com>
	<20040223081138.50f03334.rddunlap@osdl.org>
	<NkcvILAg5jOAFwZp@n-cantrell.demon.co.uk>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004 17:54:40 +0000 robert of northworthige <bobh@n-cantrell.demon.co.uk> wrote:

| In article <20040223081138.50f03334.rddunlap@osdl.org>, Randy.Dunlap
| <rddunlap@osdl.org> writes
| >On Mon, 23 Feb 2004 10:05:58 -0500 "Martin Bogomolni" <martinb@www.igotu.com> 
| >wrote:
| >
| >| 
| > 
| >| Since it doesn't seem that Hans Lermen has been updating or maintaining
| >| loadlin since the release of 2.4 is there anyone who is continuing to 
| >maintain
| >| LOADLIN, or has it fallen by the wayside?   Due to the nature of the system,
| >| and a requirement for backwards compatibility and user interaction during
| >| startup, I cannot use Peter Anvin's SYSLINUX linux loader which occurs too
| >| early on in the process.
| >| 
| >| Are there any other options to startup a linux environment from DOS?
| >
| >I don't know anything about it, but you might look at gujin:
| >  http://sourceforge.net/projects/gujin/
| >
| >--
| >~Randy
| >-
| 
| Hans produced loadlin1.6c for Pat Volkerding, about slack 8.1 time
| (kernel 2.4.18). I'm sure he'd rise to the challenge to update for 2.6
| if needed. 
| And...
| I've just tried loadlin1.6c on a 2.6.2 kernel and it's come up fine
| 
| Bob Hall
| 
| There's also linld (??) from a russian guy IIRC.

Ah, that's why I couldn't find it, I was looking for 'ldlin'.

Yes, it's here:
  http://port.imtp.ilyichevsk.odessa.ua/linux/linld/

--
~Randy
