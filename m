Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVBQShc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVBQShc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 13:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbVBQShc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 13:37:32 -0500
Received: from uni03du.unity.ncsu.edu ([152.1.13.103]:21376 "EHLO
	uni03du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S261174AbVBQShT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 13:37:19 -0500
From: jlnance@unity.ncsu.edu
Date: Thu, 17 Feb 2005 13:37:09 -0500
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [OT] speeding boot process (was Re: [ANNOUNCE] hotplug-ng 001 release)
Message-ID: <20050217183709.GA11929@ncsu.edu>
References: <420C054B.1070502@downeast.net> <20050211011609.GA27176@suse.de> <1108354011.25912.43.camel@krustophenia.net> <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de> <1108422240.28902.11.camel@krustophenia.net> <524qge20e2.fsf@topspin.com> <1108424720.32293.8.camel@krustophenia.net> <42113F6B.1080602@am.sony.com> <1108430245.32293.16.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108430245.32293.16.camel@krustophenia.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 08:17:25PM -0500, Lee Revell wrote:

> from user space to presenting a login prompt that's way too long.  My
> distro (Debian) runs all the init scripts one at a time, and GDM is the
> last thing that gets run.  There is just no reason for this.  We should
> start X and initialize the display and get the login prompt up there
> ASAP, and let the system acquire the DHCP lease and start sendmail and
> apache and get the date from the NTP server *in the background while I
> am logging in*.  It's not rocket science.

This is debatable.  Windows does something like this.  It really annoys
me that I will get a windows desktop very quickly after logging in
but that I can't do anything with it until some mystrey initialization
takes place.  I would hate to be able to log into my linux machine but
not be able to check email for the first 15 seconds.

Jim
