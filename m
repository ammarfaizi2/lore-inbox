Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUJGNLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUJGNLi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 09:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269655AbUJGNLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 09:11:16 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:23214 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269641AbUJGNJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 09:09:31 -0400
Subject: Re: [patch 1/3] lsm: add bsdjail module
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Serge Hallyn <serue@us.ibm.com>, chrisw@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041006162620.4c378320.akpm@osdl.org>
References: <1097094103.6939.5.camel@serge.austin.ibm.com>
	 <1097094270.6939.9.camel@serge.austin.ibm.com>
	 <20041006162620.4c378320.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097150790.31528.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 07 Oct 2004 13:06:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-07 at 00:26, Andrew Morton wrote:
> I don't recall anyone requesting this feature.  Tell me why we should add
> it to Linux?

Subject to the code cleanups and stuff you've noted I'd actually like to
see BSD jail stuff in our security modules because it has the virtue of
simplicity. If it can be extended to do all of vserver even better. J
Random Admin has a good chance at configuring BSD jails etups. J Random
Admin needs some serious tools that don't exist to set up SELinux the
same way.

In the security world simplicity is often a virtue, both in code and
concepts.

Alan

