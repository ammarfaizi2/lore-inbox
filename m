Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbVBQT55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbVBQT55 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 14:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVBQT55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 14:57:57 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:61962 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262309AbVBQT5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 14:57:48 -0500
Date: Thu, 17 Feb 2005 21:00:09 +0100
To: jlnance@unity.ncsu.edu
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [OT] speeding boot process (was Re: [ANNOUNCE] hotplug-ng 001 release)
Message-ID: <20050217200009.GA19956@hh.idb.hist.no>
References: <20050211011609.GA27176@suse.de> <1108354011.25912.43.camel@krustophenia.net> <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de> <1108422240.28902.11.camel@krustophenia.net> <524qge20e2.fsf@topspin.com> <1108424720.32293.8.camel@krustophenia.net> <42113F6B.1080602@am.sony.com> <1108430245.32293.16.camel@krustophenia.net> <20050217183709.GA11929@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050217183709.GA11929@ncsu.edu>
User-Agent: Mutt/1.5.6+20040907i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 01:37:09PM -0500, jlnance@unity.ncsu.edu wrote:
> On Mon, Feb 14, 2005 at 08:17:25PM -0500, Lee Revell wrote:
> 
> This is debatable.  Windows does something like this.  It really annoys
> me that I will get a windows desktop very quickly after logging in
> but that I can't do anything with it until some mystrey initialization
> takes place.  I would hate to be able to log into my linux machine but
> not be able to check email for the first 15 seconds.

Well, this will depend on your email server (pop? imap? other?)
being up.  Is it local on your machine, or external?  Either way,
being able to launch an email client (or some "new mail" notification
app) shouldn't be a problem.  It will simply not notice new mail until
the mail service comes up - but it won't fail.  It'll be as if the
mail arrived a little later.

Helge Hafting
