Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbTEMFNF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 01:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbTEMFNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 01:13:05 -0400
Received: from dp.samba.org ([66.70.73.150]:50917 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262864AbTEMFNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 01:13:04 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16064.30820.836937.824932@argo.ozlabs.ibm.com>
Date: Tue, 13 May 2003 14:45:24 +1000
To: Chris Wright <chris@wirex.com>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, gregkh@kroah.com,
       linux-security-module@wirex.com
Subject: Re: [PATCH] Early init for security modules
In-Reply-To: <20030512201325.T19432@figure1.int.wirex.com>
References: <20030512200309.C20068@figure1.int.wirex.com>
	<20030512201325.T19432@figure1.int.wirex.com>
X-Mailer: VM 7.15 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright writes:

> This is just the arch specific linker bits for the early initialization
> for security modules patch.  Does this look sane for this arch?

Looks ok to me.

Paul.
