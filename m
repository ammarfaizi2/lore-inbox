Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTGAT4r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 15:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTGAT4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 15:56:47 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:10625 "EHLO
	gatekeeper.slim") by vger.kernel.org with ESMTP id S263587AbTGAT4q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 15:56:46 -0400
Subject: Re: ata-scsi driver update
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3F01E030.9060201@pobox.com>
References: <3F00CEDC.2010806@pobox.com>
	 <1057086391.3444.3.camel@paragon.slim>  <3F01E030.9060201@pobox.com>
Content-Type: text/plain
Message-Id: <1057089782.3274.1.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-1) 
Date: 01 Jul 2003 22:03:02 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-01 at 21:25, Jeff Garzik wrote:

> hmmm.  did you run a "make mrproper" or "make distclean" before 
> building?  The above is a symptom of stale dependencies, not really any 
> kernel patch.

Ok I got it. I always get confused with directory names a and b in
patches..;-) Compiling now. (BTW what is the proper way to apply such
patches?)

Cheers,

Jurgen

