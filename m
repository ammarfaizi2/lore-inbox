Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262753AbVCJSPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbVCJSPq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 13:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbVCJSLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 13:11:13 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:56208 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262761AbVCJSAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 13:00:30 -0500
Subject: Re: [PATCH] make st seekable again
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1050310114027.11549B-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1050310114027.11549B-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110477516.28860.298.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 10 Mar 2005 17:58:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-03-10 at 16:56, Bill Davidsen wrote:
>  - leave it the way it is
>  - fix the hole and break tar
>  - wait for FSF to fix tar, then fix the hole
>  - try to fix it without breaking tar, which may not be really possible
>    and could leave part of the problem and still break tar somehow
>  - fix it, and leave the admin a way to build a kernel with the hole other
>    than just reverting the fix

If we "fix" it the FSF will probably take years.  If your vendor can't
produce a fixed tar when asked and the issue comes up, get a better
vendor ;)

Alan

