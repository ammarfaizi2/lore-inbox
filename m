Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTE3IiH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 04:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbTE3IiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 04:38:07 -0400
Received: from mail.ithnet.com ([217.64.64.8]:59916 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263452AbTE3IiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 04:38:06 -0400
Date: Fri, 30 May 2003 10:51:09 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: arjanv@redhat.com
Cc: marcelo@conectiva.com.br, m.c.p@wolk-project.de, willy@w.ods.org,
       gibbs@scsiguy.com, linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
Message-Id: <20030530105109.532a8c56.skraw@ithnet.com>
In-Reply-To: <1054282892.4897.1.camel@laptop.fenrus.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<20030524111608.GA4599@alpha.home.local>
	<20030525125811.68430bda.skraw@ithnet.com>
	<200305251447.34027.m.c.p@wolk-project.de>
	<20030526170058.105f0b9f.skraw@ithnet.com>
	<20030526164404.GA11381@alpha.home.local>
	<20030530100900.768ceeef.skraw@ithnet.com>
	<1054282892.4897.1.camel@laptop.fenrus.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 May 2003 10:21:33 +0200
Arjan van de Ven <arjanv@redhat.com> wrote:

> 
> 
> > My personal opinion is a known-to-be-broken 2.4.21 should not be released,
> > as a lot of people only try/use the releases and therefore an immediately
> > released 2.4.22-pre1 with justins driver will not be a good solution.
> 
> I think you missed the point entirely before. 2.4.21 CANNOT cause
> regressions most of all. At this point there is no way to know if the
> thing that fixes your machine breaks on 100s others that DO work
> correctly in 2.4.20. Even if it would fix 100s and break 1 it's still
> not acceptable for stable kernel releases.

Unfortunately you miss my point (which is probably too simple to be clearly
visible):
I want to give some feedback on a topic/problem I am experiencing since _long_.
I was _asked_ to do so. Additionally I am stating my _opinion_. I am _not_
telling anybody what to do. I am not in a position to do so. Very likely only
_few_ people are in such a position, very likely the maintainer of aic and
hopefully Marcelo.
Have you read all available bug reports Justin got? If you have not, don't play
with numbers.

Another personal opinion: software development tends to make things possible
that "cannot be". ;-)

Regards,
Stephan

