Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVBAWG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVBAWG1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 17:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbVBAWG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 17:06:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:27576 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262138AbVBAWGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 17:06:13 -0500
Date: Tue, 1 Feb 2005 14:05:52 -0800
From: Greg KH <greg@kroah.com>
To: Paul Mundt <paul.mundt@nokia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SuperHyway bus support
Message-ID: <20050201220552.GA13994@kroah.com>
References: <20041027075248.GA26760@pointless.research.nokia.com> <20050107072222.GB24441@kroah.com> <20050107094103.GA7408@pointless.research.nokia.com> <20050107162945.GA19043@pointless.research.nokia.com> <20050112081722.GA2745@kroah.com> <20050112124836.GA9315@pointless.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112124836.GA9315@pointless.research.nokia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 02:48:36PM +0200, Paul Mundt wrote:
> Yes, it would seem that way. Here we go again:
> 
>  drivers/sh/Makefile                      |    6 
>  drivers/sh/superhyway/Makefile           |    7 +
>  drivers/sh/superhyway/superhyway-sysfs.c |   45 ++++++
>  drivers/sh/superhyway/superhyway.c       |  201 +++++++++++++++++++++++++++++++
>  include/linux/superhyway.h               |   79 ++++++++++++
>  5 files changed, 338 insertions(+)

Sorry for taking so long on this.  I've added it to my trees and it will
show up in the next -mm releases.  After 2.6.11 is out I'll forward it
on to Linus.

thanks,

greg k-h
