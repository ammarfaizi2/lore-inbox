Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbTHYRW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 13:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbTHYRW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 13:22:28 -0400
Received: from havoc.gtf.org ([63.247.75.124]:25803 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262083AbTHYRW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 13:22:26 -0400
Date: Mon, 25 Aug 2003 13:22:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Dan Aloni <da-x@gmx.net>, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] One strdup() to rule them all
Message-ID: <20030825172226.GA8925@gtf.org>
References: <20030825161435.GB8961@callisto.yi.org> <20030825163745.GA17608@wohnheim.fh-wedel.de> <20030825170441.GA7097@gtf.org> <20030825170825.GC17608@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825170825.GC17608@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 07:08:25PM +0200, J?rn Engel wrote:
> On Mon, 25 August 2003 13:04:41 -0400, Jeff Garzik wrote:
> > 
> > Rusty created this patch, a long time ago.  :)
> 
> But it never got merged?  Was there some technical issue or was Rusty
> just too lazy to keep bugging Linus?

No, Rusty constantly submits it to Linus :)

Linus doesn't like consolidating strdup :)

	Jeff



