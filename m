Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVDMNWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVDMNWa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 09:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVDMNWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 09:22:30 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35755 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261341AbVDMNW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 09:22:29 -0400
Date: Wed, 13 Apr 2005 15:22:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Steinmetz <ast@domdv.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050413132206.GA16839@elf.ucw.cz>
References: <4259B474.4040407@domdv.de> <20050411110822.GA10401@elf.ucw.cz> <425AA19F.6040802@domdv.de> <200504112257.39708.rjw@sisk.pl> <425BCA6E.8030408@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425BCA6E.8030408@domdv.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here comes the next incarnation, this time against 2.6.12rc2.
> Unfortunately only compile tested as 2.6.12rc2 happily oopses away
> (vanilla from kernel.org, oops already sent to lkml).
> 
> Please let me know if you want any further changes.

Applied (it is *not* going to make it into 2.6.12, and not sure about
2.6.13, but it is in my local tree now. You had Kconfig and docs
changes, too, can you retransmit them?
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
