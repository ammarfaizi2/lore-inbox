Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbTLBWQT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 17:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264415AbTLBWQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 17:16:19 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:47624 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264414AbTLBWQR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 17:16:17 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: libata in 2.4.24?
Date: 2 Dec 2003 22:05:09 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bqj2al$dmc$1@gatekeeper.tmr.com>
References: <3FCB4506.8080305@wanadoo.es> <Pine.LNX.4.44.0312011209000.13692-100000@logos.cnet>
X-Trace: gatekeeper.tmr.com 1070402709 14028 192.168.12.62 (2 Dec 2003 22:05:09 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0312011209000.13692-100000@logos.cnet>,
Marcelo Tosatti  <marcelo.tosatti@cyclades.com> wrote:
| 
| 
| On Mon, 1 Dec 2003, Xose Vazquez Perez wrote:
| 
| > Marcelo Tosatti wrote:
| > 
| > > On Sat, 29 Nov 2003, Marcelo Tosatti wrote:
| > >>
| > >> I'm happy to include it in 2.4 when Jeff thinks its stable enough for a 
| > >> stable series. ;)
| > 
| > > I thought a bit more about this issue and I have a different opinion now.
| > >
| > > 2.6 is getting more and more stable and already includes libata --- users 
| > > who need it should use 2.6.
| > 
| > Does it mean that 2.4.x is going to freeze, and only critical and security
| > patches are going to be applied ?
| 
| Yes this will happen in the near future.
| 
| I still might accept some "non critical" modifications (which is btw, not
| an objective defition) to 2.4.24, but for 2.4.25 that will be the rule.

I hope you will continue to allow changes like new drivers and the
like, there are many things in 2.6 which are not only not working but
unlikely to ever be fixed because they are "old technology" and have
been replaced by more interesting and less functional alternatives, but
which are highly useful for people who have to use what is available in
terms of hardware.

That's "what the client/boss what's to provide" as well as "what the
individual can afford." It's not just hobby stuff or old PCs being used,
there are people selling laptops with ACPI more disfunctional than the
Simpsons. Suspend via APM works fine, though.

Unless a miracle occurs it will take as long for 2.6 to be really stable
and fully functional as it did for 2.[024]. When it goes out in distros
and gets abused by users for a while the sharp corners will be broken off.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
