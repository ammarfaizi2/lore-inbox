Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbVAYUYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVAYUYx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 15:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbVAYUYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 15:24:53 -0500
Received: from europa.telenet-ops.be ([195.130.132.60]:48551 "EHLO
	europa.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262109AbVAYUYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 15:24:51 -0500
Subject: Re: 2.6.11-rc2: Badness in local_bh_enable at kernel/softirq.c:140
From: Bart De Schuymer <bdschuym@pandora.be>
To: earny@net4u.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200501250336.18238.list-lkml@net4u.de>
References: <200501241919.29987.list-lkml@net4u.de>
	 <200501250336.18238.list-lkml@net4u.de>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 21:30:33 +0100
Message-Id: <1106685033.5418.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Op di, 25-01-2005 te 03:36 +0100, schreef Ernst Herzberg:
> sorry for answering to myself, but someone (:-) send me a mail with the 
> message
> 
> > Fixed in -bk on Sunday.
> 
> Thx :-)

Thanks for posting this. I was just about to go on a wild goose chase.
Any idea what patch fixed it?

cheers,
Bart


