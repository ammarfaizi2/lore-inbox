Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbTFNVpO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 17:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTFNVpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 17:45:14 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:61011 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261161AbTFNVpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 17:45:11 -0400
Subject: Re: linux-2.4.21 released
From: =?ISO-8859-1?Q?Ram=F3n?= Rey =?UTF-8?Q?Vicente?=
	 =?UTF-8?Q?=F3=AE=A0=92?= <retes_simbad@yahoo.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030614233527.08831e2a.diegocg@teleline.es>
References: <200306131453.h5DErX47015940@hera.kernel.org>
	 <20030613165628.GE28609@in-ws-001.cid-net.de>
	 <20030613172226.GB9339@merlin.emma.line.org>
	 <20030613182924.A32241@infradead.org>
	 <20030614233527.08831e2a.diegocg@teleline.es>
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1055627935.4965.6.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 14 Jun 2003 23:58:58 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El s?, 14-06-2003 a las 23:35, Diego Calleja García escribió:
> On Fri, 13 Jun 2003 18:29:24 +0100
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Fri, Jun 13, 2003 at 07:22:26PM +0200, Matthias Andree wrote:
> > > I'd add "XFS merge" to the list:
> > 
> > I'll start feeding the few remaining core changes to Marcelo now,
> > the actual filesystem then is just yet another driver that could
> > be merged any time :)
> 
> Just a small suggestion: Why not ALSA?
> I mean, 2.5 is there for new things, indeed. But alsa are drivers (ie: it
> shouldnt affect core code and you haven't to use them if you don't want) ,
> and after all it's one of those things that lots of people have to add (a
> lot of times manually and lots of people doesn't want to know how to patch
> a kernel; although all distros ship it).

I think 2.4.x series are stable versions, but on the past we saw how new
code was added to the linux stable tree if that code wasn't invasive.

ALSA have many advantages and improved coded compared with OSS, and
could add support for a few new devices. I think ALSA is an interesting
thing now, when ALSA seems very stable.
-- 
/================================================\
| Ramón Rey Vicente <ramon.rey at hispalinux.es> |
|                                                |
| Jabber ID <rreylinux at jabber.org>            |
|                                                |
| Public GPG Key http://pgp.escomposlinux.org    |
|                                                |
| GLiSa http://glisa.hispalinux.es               |
\================================================/

