Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbTEEWKO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 18:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbTEEWKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 18:10:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27342 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262140AbTEEWKN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 18:10:13 -0400
Date: Mon, 5 May 2003 23:22:40 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Pavel Machek <pavel@ucw.cz>
Cc: Gabriel Devenyi <devenyga@mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KernelJanitor: Convert remaining error returns to return -E Linux 2.5.68
Message-ID: <20030505222240.GH10374@parcelfarce.linux.theplanet.co.uk>
References: <200304292215.20590.devenyga@mcmaster.ca> <20030429224228.GQ10374@parcelfarce.linux.theplanet.co.uk> <200304292311.24117.devenyga@mcmaster.ca> <20030505221146.GA227@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030505221146.GA227@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 12:11:46AM +0200, Pavel Machek wrote:
> Hi!
> 
> > It was intended to do exactly what the KernelJanitor TODO and kj.pl script 
> > pointed out, but aparently there's more to it than that. (BTW it just says 
> > "sed s/return EWHATEVER/return -EWHATEVER/") Discouraging people with foul 
> > language isn't the best way to get more developers, this is only my first 
> > try.
> 
> That's Al Viro, it seems. He is hidding his real name? He's always
> like that

???

When the fsck had I ever stooped down to hiding my name?
