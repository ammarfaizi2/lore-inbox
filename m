Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262734AbVD2OhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbVD2OhT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbVD2OhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:37:09 -0400
Received: from verein.lst.de ([213.95.11.210]:30189 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262734AbVD2Ofu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:35:50 -0400
Date: Fri, 29 Apr 2005 16:35:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: linux-kernel@vger.kernel.org
Subject: [hch: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread]
Message-ID: <20050429143545.GB7592@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry, forgot to Cc lkml

----- Forwarded message from Christoph Hellwig <hch> -----

Date: Fri, 29 Apr 2005 16:34:51 +0200
From: Christoph Hellwig <hch>
Subject: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread
To: sfrench@us.ibm.com

care to explain what

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=f28ac91b0541a49d5bc7bfb9f0efd5289a7dd181

does and who revied that?  Things like that don't have a business in the
kernel, and certainly not as ioctl.

----- End forwarded message -----
