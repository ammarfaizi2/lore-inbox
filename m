Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbUAWJRk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 04:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbUAWJRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 04:17:40 -0500
Received: from hibernia.jakma.org ([213.79.33.168]:3724 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S261957AbUAWJRi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 04:17:38 -0500
Date: Fri, 23 Jan 2004 09:17:20 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: David Ford <david+hb@blue-labs.org>
cc: Jes Sorensen <jes@wildopensource.com>, Zan Lynx <zlynx@acm.org>,
       Andreas Jellinghaus <aj@dungeon.inka.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Confirmation Spam Blocking was: List 'linux-dvb' closed to
 public posts
In-Reply-To: <401000C1.9010901@blue-labs.org>
Message-ID: <Pine.LNX.4.58.0401230912300.2140@fogarty.jakma.org>
References: <ecartis-01212004203954.14209.1@mail.convergence2.de>
 <20040121194315.GE9327@redhat.com> <Pine.LNX.4.58.0401211155300.2123@home.osdl.org>
 <1074717499.18964.9.camel@localhost.localdomain> <20040121211550.GK9327@redhat.com>
 <20040121213027.GN23765@srv-lnx2600.matchmail.com>
 <pan.2004.01.21.23.40.00.181984@dungeon.inka.de> <1074731162.25704.10.camel@localhost.localdomain>
 <yq0hdyo15gt.fsf@wildopensource.com> <401000C1.9010901@blue-labs.org>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jan 2004, David Ford wrote:

> Considering that Bayesian filters are useless against the new spam
> that is proliferating these days, that's laughable.  Spam now comes
> with a good 5-10K of random dictionary words.

Right, but random words result in strange couplings of words.  
Statistical filters should be working on phrases, not just individual
words. So to the statistical filter random words will just be
meaningless noise, neither an indicator of goodness nor of spamness.
(unless a spammer reuses a boilerplate 'random word' section - in
which case it'll be an indicator of spamness).

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
Men of lofty genius when they are doing the least work are most active.
		-- Leonardo da Vinci
