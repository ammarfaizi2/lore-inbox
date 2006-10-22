Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWJVW3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWJVW3D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 18:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWJVW3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 18:29:01 -0400
Received: from mail.suse.de ([195.135.220.2]:41143 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750811AbWJVW27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 18:28:59 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Avi Kivity <avi@qumranet.com>, Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
References: <4537818D.4060204@qumranet.com> <200610221723.48646.arnd@arndb.de>
	<453B99D7.1050004@qumranet.com> <200610221851.06530.arnd@arndb.de>
	<1161547168.1919.38.camel@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 23 Oct 2006 00:28:58 +0200
In-Reply-To: <1161547168.1919.38.camel@localhost.localdomain>
Message-ID: <p7364ecm1cl.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Ar Sul, 2006-10-22 am 18:51 +0200, ysgrifennodd Arnd Bergmann:
> > What is the point of 32 bit hosts anyway? Isn't this only available
> > on x86_64 type CPUs in the first place?
> 
> There are a small number of vt capable 32bit only processors.

Ah you're right. I forgot about the Yonahs. The number is probably
not even that small (when Intel ships something x86 they tend to 
do it in millions)

-Andi
