Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263656AbTEWGQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 02:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbTEWGQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 02:16:25 -0400
Received: from zeus.kernel.org ([204.152.189.113]:15569 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263652AbTEWGQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 02:16:25 -0400
Date: Fri, 23 May 2003 07:27:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com
Subject: Re: Patch to add SysRq handling to 3270 console
Message-ID: <20030523072745.A5368@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Pete Zaitcev <zaitcev@redhat.com>,
	linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
References: <20030522225014$1daf@gated-at.bofh.it> <200305222316.h4MNGk8H004738@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305222316.h4MNGk8H004738@post.webmailer.de>; from arnd@arndb.de on Fri, May 23, 2003 at 01:12:20AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 01:12:20AM +0200, Arnd Bergmann wrote:
> duplicated work. Do you have a tested backport for 2.4.2x? If
> so, we could merge it for the z990 code drop.

What is the z990 code drop?  Can you please merge support for new
hardware into mainline instead of realsing it in these silly IBM
patchkits for old kernels with exploitable security issues..

Btw, what's the state of 2.4.21-rc3 vs s390(x)?
