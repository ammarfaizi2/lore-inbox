Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264109AbTH1SNz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 14:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbTH1SNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 14:13:55 -0400
Received: from p15108950.pureserver.info ([217.160.128.7]:2195 "EHLO
	pluto.schiffbauer.net") by vger.kernel.org with ESMTP
	id S264109AbTH1SNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 14:13:52 -0400
Date: Thu, 28 Aug 2003 20:14:04 +0200
From: Marc Schiffbauer <marc.schiffbauer@links2linux.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Spam? was: Linux 2.4.23-pre1
Message-ID: <20030828181404.GA28637@lisa>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0308271449170.23236@freak.distro.conectiva> <20030828174247.GD21352@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030828174247.GD21352@matchmail.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.20-hpt i686
X-Editor: vim 6.1.018-1
X-Homepage: http://www.links2linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mike Fedyk schrieb am 28.08.03 um 19:42 Uhr:
> On Wed, Aug 27, 2003 at 02:52:45PM -0300, Marcelo Tosatti wrote:
> > This mail is probably spam.  The original message has been attached
> > along with this report, so you can recognize or block similar unwanted
> > mail in future.  See http://spamassassin.org/tag/ for more details.
> > 
> > Content preview:  Hello, Here goes the first -pre of 2.4.23. It contains
> >   a bunch of updates spread all over, most notably networking. There are
> >   still pending patches in my queue, but I though "Ok, enough patches for
> >   a -pre. " [...] 
> > 
> > Content analysis details:   (6.00 points, 5 required)
> > USER_AGENT_PINE    (0.0 points)  Message-Id indicates a non-spam MUA (Pine)
> > X_MAILING_LIST     (0.0 points)  Has a X-Mailing-List header
> > ROUND_THE_WORLD    (2.5 points)  Received: says mail bounced around the world (DNS)
> > RCVD_IN_OSIRUSOFT_COM (0.6 points)  RBL: Received via a relay in relays.osirusoft.com
> >                    [RBL check: found 212.78.72.67.relays.osirusoft.com.]
> > X_OSIRU_OPEN_RELAY (2.9 points)  RBL: DNSBL: sender is Confirmed Open Relay
> 
> This was marked as spam from spamassassin.
> 
> Note the entry in RBL for this server...
> 
> Just letting you guys know.
> 

This is because the osirusoft.com RBL server has been under attack
(ddos) last weekend. Answers by this server were always "listed"
during this time. This is not a lucky default IMHO but it was like
that.

See also: http://www.heise.de/newsticker/data/uma-27.08.03-000/
(for those who read german)

For me it was worse because my exim used this server directly and
did not mark those mails as spam but completely blocked all mails
:-(

BTW: Does newest release contain this rules (*_OSIRUSOFT_*) by
default?

-Marc

-- 
8AAC 5F46 83B4 DB70 8317  3723 296C 6CCA 35A6 4134
