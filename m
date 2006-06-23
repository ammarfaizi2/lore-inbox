Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751960AbWFWTlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbWFWTlL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 15:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbWFWTlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 15:41:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57360 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751960AbWFWTlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 15:41:10 -0400
Date: Fri, 23 Jun 2006 20:41:01 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Frederik Deweerdt <deweerdt@free.fr>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org, linux-pm@osdl.org,
       stern@rowland.harvard.edu
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
Message-ID: <20060623194100.GA3812@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Frederik Deweerdt <deweerdt@free.fr>, Andrew Morton <akpm@osdl.org>,
	greg@kroah.com, linux-kernel@vger.kernel.org, linux-pm@osdl.org,
	stern@rowland.harvard.edu
References: <20060621034857.35cfe36f.akpm@osdl.org> <4499BE99.6010508@gmail.com> <20060621221445.GB3798@inferi.kami.home> <20060622061905.GD15834@kroah.com> <20060622004648.f1912e34.akpm@osdl.org> <20060622160403.GB2539@slug> <20060622092506.da2a8bf4.akpm@osdl.org> <20060623090206.GA2234@slug> <20060623091016.GE4940@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623091016.GE4940@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 11:10:21AM +0200, Pavel Machek wrote:
> Serial console is currently broken by suspend, resume. _But_ I have a
> patch I'd like you to try.... pretty please?

Did you bother trying my patch, which was done the Right(tm) way?
There wasn't any feedback on it so I can only assume not.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
