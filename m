Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbVIOAsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbVIOAsb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 20:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVIOAsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 20:48:31 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:9397
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S932495AbVIOAsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 20:48:30 -0400
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
Reply-To: abonilla@linuxwireless.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1126674993.5681.9.camel@localhost.localdomain>
References: <7255.1126583985@kao2.melbourne.sgi.com>
	 <1126674993.5681.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 18:48:42 -0600
Message-Id: <1126745323.7199.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-13 at 23:16 -0600, Alejandro Bonilla Beeche wrote:
> On Tue, 2005-09-13 at 13:59 +1000, Keith Owens wrote:
> > On Mon, 12 Sep 2005 21:54:29 -0600, 
> > Alejandro Bonilla Beeche <abonilla@linuxwireless.org> wrote:
> > >If I do make menuconfig, it still says 2.6.13 instead of 2.6.14-rc1.
> > 
> > rsync.kernel.org has not been updated from the master yet.  Give it an
> > hour and try again.

Linus,

	Thanks for the tip. git checkout -f did it. I dunno but I always run
it, anyway, it worked now that you mentioned it. ;-)

Additionally,

debian:~# cd linux-2.6/
debian:~/linux-2.6# git log
/usr/local/bin/git-log-script: line 4: less: command not found

Anyway! I can see how it is updated now.

Thanks!

.Alejandro

