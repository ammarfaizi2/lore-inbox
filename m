Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbVLPQif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVLPQif (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 11:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbVLPQie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 11:38:34 -0500
Received: from verein.lst.de ([213.95.11.210]:64671 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932353AbVLPQie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 11:38:34 -0500
Date: Fri, 16 Dec 2005 17:38:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dasd: remove dynamic ioctl registration
Message-ID: <20051216163825.GA21977@lst.de>
References: <20051216143348.GB19541@lst.de> <1134745099.5495.31.camel@localhost.localdomain> <20051216150058.GA20144@lst.de> <1134750741.5495.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134750741.5495.40.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok understood, but at least I have warn the EMC people about that change
> so that they can send a patch for the dasd driver ..

Sure, at this patch is a 2.6.16 thing, which is more than enough time
for them.  I'm happy to review any code they submit for kernel
inclusion.

