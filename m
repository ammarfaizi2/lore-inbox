Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVBSF4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVBSF4f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 00:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVBSF4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 00:56:35 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:33267 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261639AbVBSF4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 00:56:30 -0500
Message-ID: <4216D509.7050206@why.dont.jablowme.net>
Date: Sat, 19 Feb 2005 00:56:25 -0500
From: Jim Crilly <jim@why.dont.jablowme.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: jlnance@unity.ncsu.edu, Lee Revell <rlrevell@joe-job.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [OT] speeding boot process (was Re: [ANNOUNCE] hotplug-ng 001
 release)
References: <20050211011609.GA27176@suse.de> <1108354011.25912.43.camel@krustophenia.net> <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de> <1108422240.28902.11.camel@krustophenia.net> <524qge20e2.fsf@topspin.com> <1108424720.32293.8.camel@krustophenia.net> <42113F6B.1080602@am.sony.com> <1108430245.32293.16.camel@krustophenia.net> <20050217183709.GA11929@ncsu.edu> <20050217200009.GA19956@hh.idb.hist.no>
In-Reply-To: <20050217200009.GA19956@hh.idb.hist.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> 
> 
> Well, this will depend on your email server (pop? imap? other?)
> being up.  Is it local on your machine, or external?  Either way,
> being able to launch an email client (or some "new mail" notification
> app) shouldn't be a problem.  It will simply not notice new mail until
> the mail service comes up - but it won't fail.  It'll be as if the
> mail arrived a little later.

Sure it can fail, when you start it up it'll most likely fail to login to 
the mail server, whether it's local or not, if certain services aren't 
already started. If you're using local direct access via maildir or mbox, 
that'll work fine but most people access remote server for their mail.

> 
> Helge Hafting

Jim.
