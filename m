Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269660AbTGWLEs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 07:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269900AbTGWLEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 07:04:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54540 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S269660AbTGWLEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 07:04:47 -0400
Date: Wed, 23 Jul 2003 13:16:34 +0200
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: Jan Kasprzak <kas@informatics.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Non-ASCII chars in visor.c messages
Message-ID: <20030723111634.GC729@zaurus.ucw.cz>
References: <20030722143821.C26218@fi.muni.cz> <20030722125039.GA2310@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722125039.GA2310@kroah.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 	What do you think about it?
> 
> I don't think it's really needed.  Why change this, syslog can't handle
> this?  It works for me...
> 

It would not work here. Make it us-ascii.

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

