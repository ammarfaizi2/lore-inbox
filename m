Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbTIQCtP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 22:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbTIQCtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 22:49:15 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:47368 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S262669AbTIQCtM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 22:49:12 -0400
Date: Wed, 17 Sep 2003 03:49:11 +0100
From: John Levon <levon@movementarian.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export new char dev functions
Message-ID: <20030917024911.GA35464@compsoc.man.ac.uk>
References: <20030916235729.GA6198@kroah.com> <20030917023630.24595.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030917023630.24595.qmail@lwn.net>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19zSNT-000M1p-Cu*xRQSGxH/C22*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 08:36:30PM -0600, Jonathan Corbet wrote:

> Of course, there are other exports from that file (i.e. register_chrdev());
> are we actively trying to shrink ksyms.c?

I think we are, yes. ksyms.c just makes life harder.

regards
john

-- 
Khendon's Law:
If the same point is made twice by the same person, the thread is over.
