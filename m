Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263197AbTDVPCo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 11:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263198AbTDVPCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 11:02:43 -0400
Received: from havoc.daloft.com ([64.213.145.173]:38798 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263197AbTDVPCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 11:02:38 -0400
Date: Tue, 22 Apr 2003 11:14:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: boot messages
Message-ID: <20030422151443.GA25026@gtf.org>
References: <UTC200304221245.h3MCjp122735.aeb@smtp.cwi.nl> <20030422130135.GA16465@gtf.org> <20030422072023.5fa430b6.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030422072023.5fa430b6.rddunlap@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 07:20:23AM -0700, Randy.Dunlap wrote:
> | changed between 2.4 and 2.5.  I consider this a bug, and welcome patches
> | to fix it.  Note, though, that the recent PCI probe order fixes that
> | went in via Andrew Morton may have addressed this issue for some people.
> 
> Patch has already been posted 2 times.

Out of sight, out of mind.  :)

I am also wondering how link order and PCI detection order are affecting
things, so re-testing without patches on 2.5.68-bk3 would be useful, for
those having problems.

Re-send the patch against 2.5.68-bk3 if the problem persists...

	Jeff



