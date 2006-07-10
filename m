Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWGJJSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWGJJSq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWGJJSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:18:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:64223 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932469AbWGJJSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:18:45 -0400
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
From: Arjan van de Ven <arjan@infradead.org>
To: dirk husemann <hud@zurich.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, suspend2-devel@lists.suspend2.net,
       Avuton Olrich <avuton@gmail.com>, Olivier Galibert <galibert@pobox.com>,
       Jan Rychter <jan@rychter.com>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>, grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
In-Reply-To: <44B219CC.4010409@zurich.ibm.com>
References: <20060627133321.GB3019@elf.ucw.cz>
	 <ce9ef0d90607080942w685a6b60q7611278856c78ac0@mail.gmail.com>
	 <1152377434.3120.69.camel@laptopd505.fenrus.org>
	 <200607082125.12819.rjw@sisk.pl>
	 <1152387552.3120.89.camel@laptopd505.fenrus.org>
	 <44B219CC.4010409@zurich.ibm.com>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 11:18:28 +0200
Message-Id: <1152523109.4874.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 11:11 +0200, dirk husemann wrote:
> Arjan van de Ven wrote:
> >>  so that it's as
> >> feature-rich as the other one.
> >>     
> >
> > this is one of the things that bothers me.
> > "features features features"
> > lets first get the basics right and working.
> > Once we have that in tree for a release or two and it's really
> > reliable... THEN and only THEN work on adding features.
> >   
> hmm...could it be that we "features, features, features" in suspend2
> because nigel & co did get the basics right?

As I said... if that is the case then it'd be easy to first merge "the
right basics", get that solid, and THEN add the features. So far I've
not seen that happen.


