Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268915AbUH3T7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268915AbUH3T7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 15:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268944AbUH3T6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 15:58:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:65495 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268907AbUH3T50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 15:57:26 -0400
Date: Mon, 30 Aug 2004 12:55:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: bunk@fs.tum.de, linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org
Subject: Re: [patch] 2.6.9-rc1-mm1: megaraid_mbox.c compile error with gcc
 3.4
Message-Id: <20040830125509.46ea399c.akpm@osdl.org>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BC9C6@exa-atlanta>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC9C6@exa-atlanta>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mukker, Atul" <Atulm@lsil.com> wrote:
>
> 2.	The guideline on the size of patches. Because of the new driver, the
>  size of the patches for megaraid are relatively big (the small patches are
>  always inlined). Should it be discretionary for submitter to either inline,
>  attach, or (deprecated) send a link, based on size of the package.

Sending a URL to a big patch is a necessary evil for mailing lists, so the
best approach would be to also mail the patches directly to the guy(s) who
you wish to apply them.

An even better approach is to split the patches up so they are not so big ;)

Following the "once concept per patch rule" works well.
