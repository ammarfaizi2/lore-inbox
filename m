Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965081AbWFIKq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbWFIKq3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 06:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWFIKq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 06:46:29 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26789 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932287AbWFIKq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 06:46:28 -0400
Date: Fri, 9 Jun 2006 12:45:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Oliver Bock <o.bock@fh-wolfenbuettel.de>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, alan@redhat.com
Subject: Re: [PATCH 1/1] usb: new driver for Cypress CY7C63xxx mirco controllers
Message-ID: <20060609104541.GB16232@elf.ucw.cz>
References: <200606082257.23286.o.bock@fh-wolfenbuettel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200606082257.23286.o.bock@fh-wolfenbuettel.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 08-06-06 22:57:18, Oliver Bock wrote:
> From: Oliver Bock <o.bock@fh-wolfenbuettel.de>
> 
> This is a new driver for the Cypress CY7C63xxx mirco controller series. It 
> currently supports the pre-programmed CYC63001A-PC by AK Modul-Bus GmbH.
> It's based on a kernel 2.4 driver (cyport) by Marcus Maul which I ported to kernel 2.6 
> using sysfs. I intend to support more controllers of this family (and more features) as
> soon as I get hold of the required IDs etc. Please see the source code's header for
> more information.

I see "a" letters here tabs should have been. You probably need to
resend...


> Please CC me as I'm not yet subscribed to LKML. Any comments are welcome.
> Special thanks to Greg K-H for his helpful support!
> 
> diff against 2.6.16.19

Ugh, and new drivers should really go against 2.6.17-rcX.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
