Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVBSWpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVBSWpk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 17:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVBSWpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 17:45:40 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:26378 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262155AbVBSWpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 17:45:34 -0500
Date: Sat, 19 Feb 2005 23:47:59 +0100
To: Jim Crilly <jim@why.dont.jablowme.net>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, jlnance@unity.ncsu.edu,
       Lee Revell <rlrevell@joe-job.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [OT] speeding boot process (was Re: [ANNOUNCE] hotplug-ng 001 release)
Message-ID: <20050219224759.GA22874@hh.idb.hist.no>
References: <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de> <1108422240.28902.11.camel@krustophenia.net> <524qge20e2.fsf@topspin.com> <1108424720.32293.8.camel@krustophenia.net> <42113F6B.1080602@am.sony.com> <1108430245.32293.16.camel@krustophenia.net> <20050217183709.GA11929@ncsu.edu> <20050217200009.GA19956@hh.idb.hist.no> <4216D509.7050206@why.dont.jablowme.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4216D509.7050206@why.dont.jablowme.net>
User-Agent: Mutt/1.5.6+20040907i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2005 at 12:56:25AM -0500, Jim Crilly wrote:
> Helge Hafting wrote:
> >
> >
> >Well, this will depend on your email server (pop? imap? other?)
> >being up.  Is it local on your machine, or external?  Either way,
> >being able to launch an email client (or some "new mail" notification
> >app) shouldn't be a problem.  It will simply not notice new mail until
> >the mail service comes up - but it won't fail.  It'll be as if the
> >mail arrived a little later.
> 
> Sure it can fail, when you start it up it'll most likely fail to login to 
> the mail server, whether it's local or not, if certain services aren't 
> already started. If you're using local direct access via maildir or mbox, 
> that'll work fine but most people access remote server for their mail.
> 
No problem with the remote server, it does not depend on the local boot process.
The mail program connects directly to the remote server, all you need is the
network and it comes up so fast, it will come up way before X in a parallel boot.

Helge Hafting
