Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbTIQXJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 19:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbTIQXJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 19:09:26 -0400
Received: from havoc.gtf.org ([63.247.75.124]:38316 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262902AbTIQXJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 19:09:25 -0400
Date: Wed, 17 Sep 2003 19:09:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Export new char dev functions
Message-ID: <20030917230925.GB7428@gtf.org>
References: <20030917224549.GD4920@gtf.org> <20030917230353.3610.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030917230353.3610.qmail@lwn.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17, 2003 at 05:03:53PM -0600, Jonathan Corbet wrote:
> > Need to modify export-objs line in fs/Makefile too.
> 
> I do?  In 2.5??  I thought that was old, obsolete stuff?
> 
> I sure don't find any export-objs lines in -test5...

Nope, you're correct.  I was looking at 2.4...

	Jeff



