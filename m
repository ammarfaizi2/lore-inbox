Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbVI0Icj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbVI0Icj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 04:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbVI0Icj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 04:32:39 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:56205 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S964861AbVI0Ici (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 04:32:38 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] pci_ids.h: cleanup: whitespace and remove unused entries
Date: Tue, 27 Sep 2005 18:32:12 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <1l0ij15ofhfsmhp3ijerg42uiv8v471jqr@4ax.com>
References: <937ti1hpvcjdk8hf894h651s81nu6il239@4ax.com> <20050926213557.GA21973@kroah.com>
In-Reply-To: <20050926213557.GA21973@kroah.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2005 14:35:57 -0700, Greg KH <greg@kroah.com> wrote:

>I don't think you need the change to the comments at the top of the
>file.
Okay

>Also, I thought we wanted to keep all of the pci class ids, why did you
>delete them?

I'll give 'em back then ;)

>              We should start by removing the pci device and vendor ids
>that are not currently used by the kernel, and then slowly move those
>ids into the individual drivers, starting with the device ids, and maybe
>eventually moving to the vendor ids.
>
>Sound ok?

Yep, I'll go find that script, bash it some more...  I'll leave the
whitespace cleanup to last, since we gonna delete most of pci_ids.h?

Thanks,
Grant.

