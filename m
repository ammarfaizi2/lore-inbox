Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbTEQVlv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 17:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbTEQVlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 17:41:51 -0400
Received: from ip68-4-255-84.oc.oc.cox.net ([68.4.255.84]:48017 "EHLO
	ip68-101-124-193.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id S261852AbTEQVlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 17:41:49 -0400
Date: Sat, 17 May 2003 14:54:42 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: dak@gnu.org
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Scheduling problem with 2.4?
Message-ID: <20030517215442.GB2411@ip68-101-124-193.oc.oc.cox.net>
References: <x54r3tddhs.fsf@lola.goethe.zz> <20030517174100.GT1429@dualathlon.random> <x5r86x74ci.fsf@lola.goethe.zz> <20030517203045.GZ1429@dualathlon.random> <x565o9717j.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x565o9717j.fsf@lola.goethe.zz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 10:44:16PM +0200, David Kastrup wrote:
> I am talking about the kernel coming with RedHat 9, uname -a gives
> Linux lola.goethe.zz 2.4.20-8 #1 Thu Mar 13 17:54:28 EST 2003 i686 i686 i386 GNU/Linux
> 
> Unfortunately, this kernel is here to stay for quite a while, and I
> would want to find a way to let Emacs cooperate with it better without
> telling people to recompile the kernel or wait a year.

They should be upgrading to the kernel here, at least, for security
reasons:
https://rhn.redhat.com/errata/RHSA-2003-172.html

I have no idea what effect, if any, it would have on your performance
problems though.

-Barry K. Nathan <barryn@pobox.com>
