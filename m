Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268077AbUHQCRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268077AbUHQCRG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 22:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268076AbUHQCRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 22:17:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:47037 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268078AbUHQCRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 22:17:03 -0400
Date: Mon, 16 Aug 2004 19:15:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Warren Togami <wtogami@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Merge I2O patches from -mm
Message-Id: <20040816191508.428f1022.akpm@osdl.org>
In-Reply-To: <411F37CC.3020909@redhat.com>
References: <411F37CC.3020909@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Warren Togami <wtogami@redhat.com> wrote:
>
> This is a request to please merge the I2O patches currently in Andrew 
> Morton's -mm tree into the mainline kernel.  They resolve all known 
> reported issues with I2O RAID devices.  If they can be included soon, it 
> would be possible to implement and test direct installation before FC3 
> Test2 freeze.

We'll get it in when Linus returns.

> Also because Markus would never ask himself, I nominate Markus Lidel as 
> the "maintainer" of the 2.6 generic I2O layer.  He has put a tremendous 
> amount of work into improving an otherwise neglected part of the kernel. 

No problem with that, but we wouldn't want to go adding Markus to
./MAINTAINERS without his approval.

>   Thanks to his efforts it is today usable and stable on multiple archs 
> and all known supported cards.

yup.
