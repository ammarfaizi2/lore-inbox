Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262569AbUKECqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbUKECqj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 21:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbUKECqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 21:46:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47529 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262569AbUKECqc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 21:46:32 -0500
Message-ID: <418AE97A.9040003@pobox.com>
Date: Thu, 04 Nov 2004 21:46:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
CC: Andrew Morton <akpm@osdl.org>, jgarzik@mandrakesoft.com,
       orinoco-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Cosmetic updates for orinoco driver
References: <20041103022444.GA14267@zax> <20041103154407.4d9833ca.akpm@osdl.org> <20041104021228.GA3949@zax>
In-Reply-To: <20041104021228.GA3949@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:
> Ah, looks like Al Viro did the ioread/iowrite conversion while I
> wasn't looking.  Ok, with that netdev patch I should be able to fix
> things up (and merge the iowrite conversion back into CVS).

OK, I guess I will wait for an update.  What should I do with "Another 
trivial orinoco update", which looks OK to me?

	Jeff


