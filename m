Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263779AbTDUGqS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 02:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263780AbTDUGqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 02:46:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17840 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263779AbTDUGqR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 02:46:17 -0400
Message-ID: <3EA3967F.2010904@pobox.com>
Date: Mon, 21 Apr 2003 02:58:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: BK->CVS, kernel.bkbits.net
References: <20030417162723.GA29380@work.bitmover.com>	<b7n46e$dtb$1@cesium.transmeta.com>	<20030420003021.GA10547@work.bitmover.com> <16035.30645.648954.185797@notabene.cse.unsw.edu.au>
In-Reply-To: <16035.30645.648954.185797@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> That is an order of magnitude difference in wall-clock time!  This is
> on my humble notebook with "only" 128Meg of RAM.  The delay is mostly 
> in the consistency checking.  Sure there is a way to turn that off.


Yeah, my laptop w/ 128M is the same.  I think you need at least 256M for 
vaguely usable caching, and preferably 512M or more :)

	Jeff



