Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVATWbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVATWbG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 17:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbVATWbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 17:31:06 -0500
Received: from Mail.MNSU.EDU ([134.29.1.12]:15074 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S262179AbVATWbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 17:31:00 -0500
Message-ID: <41F0310F.8050506@mnsu.edu>
Date: Thu, 20 Jan 2005 16:30:39 -0600
From: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
CC: Jakob Oestergaard <jakob@unthought.net>,
       Christoph Hellwig <hch@infradead.org>,
       David Greaves <david@dgreaves.com>, Jan Kasprzak <kas@fi.muni.cz>,
       linux-kernel@vger.kernel.org, kruty@fi.muni.cz
Subject: Re: journaled filesystems -- known instability; Was: XFS: inode with
 st_mode == 0
References: <20041209125918.GO9994@fi.muni.cz> <20041209135322.GK347@unthought.net> <20041209215414.GA21503@infradead.org> <20041221184304.GF16913@fi.muni.cz> <20041222084158.GG347@unthought.net> <20041222182344.GB14586@infradead.org> <41E80C1F.3070905@dgreaves.com> <20050114182308.GE347@unthought.net> <20050116135112.GA24814@infradead.org> <20050117100746.GI347@unthought.net> <41EC2ECF.6010701@mnsu.edu>
In-Reply-To: <41EC2ECF.6010701@mnsu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey Hundstad wrote:

> For more of this look up subjects:
>  Bad things happening to journaled filesystem machines
>  Oops in kjournald
> and from author:
>  Anders Saaby
>
> I also can't keep a recent 2.6 or 2.6*-ac* kernel up more than a few 
> hours on a machine under real load.   Perhaps us folks with the 
> problem need to talk to the powers who be to come up with a strategy 
> to make a report they can use.  My guess is we're not sending 
> something that can be used.
>
I have found two server in my operation that seem to do quite well on 
linux-2.6.7.  So I believe the brokenness is after this point and before 
linux-2.6.8.1.

...so far I'm not seeing problems after two days with 
linux-2.6.10-ac10.  I'm still crossing my fingers and knocking on wood.

-- 
jeffrey hundstad

