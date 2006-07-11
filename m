Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWGKLdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWGKLdy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 07:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWGKLdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 07:33:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40422 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751068AbWGKLdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 07:33:54 -0400
Date: Tue, 11 Jul 2006 13:33:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Brad Campbell <brad@wasp.net.au>
Cc: suspend2-devel@lists.suspend2.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: /dev/rtc not suspending/resuming properly
Message-ID: <20060711113326.GA1657@elf.ucw.cz>
References: <44B24CEB.9010103@wasp.net.au> <20060710223629.GA7443@elf.ucw.cz> <44B359F7.3050500@wasp.net.au> <20060711111834.GB1670@elf.ucw.cz> <44B38C1E.8050008@wasp.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B38C1E.8050008@wasp.net.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >So you are working on sparc?
> 
> No, I'm not.. the x86 part looks relatively easy, but given it appears to 
> be used on multiple platforms I was wondering how not to break them in the 
> process..

Well... in that case do it as proper platform_device, then ask sparc
people to fix their platform ;-)).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
