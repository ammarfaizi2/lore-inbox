Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbTD3Pcd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 11:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbTD3Pcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 11:32:33 -0400
Received: from dp.samba.org ([66.70.73.150]:14284 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262293AbTD3Pcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 11:32:31 -0400
Date: Thu, 1 May 2003 01:42:36 +1000
From: Anton Blanchard <anton@samba.org>
To: Christoph Hellwig <hch@infradead.org>,
       chas williams <chas@locutus.cmf.nrl.navy.mil>,
       David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add a stub by which a module can bind to the AFS syscall
Message-ID: <20030430154235.GA29244@krispykreme>
References: <20030430160239.A8956@infradead.org> <200304301513.h3UFDNGi023355@locutus.cmf.nrl.navy.mil> <20030430162739.A9255@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030430162739.A9255@infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Oh yes, it was.  The same mistake as the even earlier SysV IPC mess.

And multiplexed syscalls are a pain for people like me who have to write
32/64 bit translations.

Anton
