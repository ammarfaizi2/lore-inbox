Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWALP3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWALP3p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 10:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWALP3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 10:29:45 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46756 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751250AbWALP3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 10:29:44 -0500
Date: Thu, 12 Jan 2006 16:29:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org, linux-pm@osdl.org
Subject: Re: [RFC: -mm patch] swsusp: make some code static
Message-ID: <20060112152935.GD9752@elf.ucw.cz>
References: <20060111042135.24faf878.akpm@osdl.org> <20060112104812.GR29663@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060112104812.GR29663@stusta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 12-01-06 11:48:12, Adrian Bunk wrote:
> On Wed, Jan 11, 2006 at 04:21:35AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.15-mm2:
> >...
> > +swsusp-low-level-interface-rev-2.patch
> >...
> >  swsusp updates
> >...
> 
> After this patch, we can make some code static.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Rafael should comment here. It is okay, but Rafael has some patches in
the queue, and it would be better if there were to clashes.
								Pavel

-- 
Thanks, Sharp!
