Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVBBBsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVBBBsu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 20:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVBBBsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 20:48:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37504 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262195AbVBBBsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 20:48:47 -0500
Message-ID: <4200316F.7030401@pobox.com>
Date: Tue, 01 Feb 2005 20:48:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
CC: orinoco-devel@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [0/8] orinoco driver updates
References: <20050112052352.GA30426@localhost.localdomain>
In-Reply-To: <20050112052352.GA30426@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:
> Following are a bunch of patches which make a few more steps towards
> the long overdue merge of the CVS orinoco driver into mainline.  These
> do make behavioural changes to the driver, but they should all be
> trivial and largely cosmetic.

OK, the changes look good, but I was waiting for the previous stuff you 
submitted to land in upstream.

Could I convince you to rediff and resend against the latest 2.6.x snapshot?

At the time you sent these, they conflicted with a previous cleanup you 
had sent, and that I had applied.

	Jeff



