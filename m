Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWGJKCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWGJKCF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 06:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWGJKCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 06:02:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59586 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751342AbWGJKCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 06:02:01 -0400
Date: Mon, 10 Jul 2006 12:02:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Arjan van de Ven <arjan@infradead.org>
Cc: dirk husemann <hud@zurich.ibm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       suspend2-devel@lists.suspend2.net, Avuton Olrich <avuton@gmail.com>,
       Olivier Galibert <galibert@pobox.com>, Jan Rychter <jan@rychter.com>,
       linux-kernel@vger.kernel.org, grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Message-ID: <20060710100227.GA25310@atrey.karlin.mff.cuni.cz>
References: <20060627133321.GB3019@elf.ucw.cz> <ce9ef0d90607080942w685a6b60q7611278856c78ac0@mail.gmail.com> <1152377434.3120.69.camel@laptopd505.fenrus.org> <200607082125.12819.rjw@sisk.pl> <1152387552.3120.89.camel@laptopd505.fenrus.org> <44B219CC.4010409@zurich.ibm.com> <1152523109.4874.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152523109.4874.11.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >>  so that it's as
> > >> feature-rich as the other one.
> > >>     
> > >
> > > this is one of the things that bothers me.
> > > "features features features"
> > > lets first get the basics right and working.
> > > Once we have that in tree for a release or two and it's really
> > > reliable... THEN and only THEN work on adding features.
> > >   
> > hmm...could it be that we "features, features, features" in suspend2
> > because nigel & co did get the basics right?
> 
> As I said... if that is the case then it'd be easy to first merge "the
> right basics", get that solid, and THEN add the features. So far I've
> not seen that happen.

Well.. Nigel claims his code can not be split into reasonable chunks.

I actually wanted to get a version without advanced features
(userspace splash, compression, encryption, plugins), but he claims it
is not possible. Rafael is trying to persuade him to split out at
least freezer out...
								Pavel
-- 
Thanks, Sharp!
