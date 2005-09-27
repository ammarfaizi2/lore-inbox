Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbVI0VVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbVI0VVW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965150AbVI0VVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:21:22 -0400
Received: from mail.dvmed.net ([216.237.124.58]:18908 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965148AbVI0VVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:21:21 -0400
Message-ID: <4339B7CD.7040307@pobox.com>
Date: Tue, 27 Sep 2005 17:21:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Coady <grant_lkml@dodo.com.au>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci_ids: remove duplicated and non-referenced symbols
References: <f39ij1pe755t19dpgn5teed8e7069u3fmf@4ax.com>
In-Reply-To: <f39ij1pe755t19dpgn5teed8e7069u3fmf@4ax.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:
> Hi Greg, All,
> 
> Attached is first patch to cleanup pci_ids.h, compressed as it is 68k 
> straight text.  More patches to follow moving device IDs to where they 
> be referenced.  Whitespace cleanup planned at end of patch series.

I agree with this patch, but disagree with the suggested future patches.

	Jeff



