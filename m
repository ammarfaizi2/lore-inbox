Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVCCJel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVCCJel (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 04:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVCCJcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 04:32:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31373 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261836AbVCCJbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 04:31:49 -0500
Message-ID: <4226D975.5010907@pobox.com>
Date: Thu, 03 Mar 2005 04:31:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: greg@kroah.com, davem@davemloft.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <42265A6F.8030609@pobox.com>	<20050302165830.0a74b85c.davem@davemloft.net>	<422674A4.9080209@pobox.com>	<Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>	<42268749.4010504@pobox.com>	<20050302200214.3e4f0015.davem@davemloft.net>	<42268F93.6060504@pobox.com>	<4226969E.5020101@pobox.com>	<20050302205826.523b9144.davem@davemloft.net>	<4226C235.1070609@pobox.com>	<20050303080459.GA29235@kroah.com>	<4226CA7E.4090905@pobox.com> <20050303011755.56fddee0.akpm@osdl.org>
In-Reply-To: <20050303011755.56fddee0.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>We have all these problems precisely because _nobody_ is saying "I'm 
>> only going to accept bug fixes".  We _need_ some amount of release 
>> engineering.  Right now we basically have none.
> 
> 
> Sorry Jeff, but that's crap.  Go look at the commits list.  Every single
> patch which has gone into the tree for the past two weeks is a bugfix, I
> think.

It's an an exaggeration, but what do users that don't follow daily 
kernel development see?

"oh, somewhere between -rc1 and -rc5 they got serious about taking only 
bugfixes.  Andrew Morton says it was the past few weeks... what -rc is 
that?"

	Jeff


