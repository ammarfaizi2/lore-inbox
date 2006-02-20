Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161105AbWBTSS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161105AbWBTSS6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 13:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161106AbWBTSS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 13:18:58 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:57490 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161105AbWBTSS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 13:18:57 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: dtor_core@ameritech.net
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 20 Feb 2006 19:19:19 +0100
User-Agent: KMail/1.9.1
Cc: "Pavel Machek" <pavel@ucw.cz>, "Mark Lord" <lkml@rtr.ca>,
       "Nigel Cunningham" <nigel@suspend2.net>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "Matthias Hensler" <matthias@wspse.de>,
       "Sebastian Kgler" <sebas@kde.org>,
       "kernel list" <linux-kernel@vger.kernel.org>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602201823.22870.rjw@sisk.pl> <d120d5000602200933v24cf9fbchb44c229459d74179@mail.gmail.com>
In-Reply-To: <d120d5000602200933v24cf9fbchb44c229459d74179@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602201919.21267.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 18:33, Dmitry Torokhov wrote:
> On 2/20/06, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Monday 20 February 2006 17:30, Dmitry Torokhov wrote:
> > >
> > > Latest -mm is way too big a target. Do you have a specific patches in
> > > mind? Again my working kernel is based off tip of Linus's tree plus my
> > > patches, not -mm.
> >
> > What architecture is it running on?
> >
> 
> i386, nothing fancy.

OK, I'll try to figure out what exactly is wrong, but I'll need to set up an
i386 test bed for this purpose which will take a few days.

Greetings,
Rafael
