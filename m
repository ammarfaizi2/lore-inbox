Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268427AbTCCICT>; Mon, 3 Mar 2003 03:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268431AbTCCICT>; Mon, 3 Mar 2003 03:02:19 -0500
Received: from [195.128.145.236] ([195.128.145.236]:33152 "EHLO hippo.ru")
	by vger.kernel.org with ESMTP id <S268427AbTCCICQ>;
	Mon, 3 Mar 2003 03:02:16 -0500
Date: Mon, 3 Mar 2003 13:38:32 +0400
From: Vlad Harchev <hvv@hippo.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and cryptofs on raid1 - what will be cached and how many times
Message-ID: <20030303093832.GA4601@h>
References: <20030302105634.GA4258@h>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030302105634.GA4258@h>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 02, 2003 at 02:56:34PM +0400, Vlad Harchev wrote:
> Hello, 
> 
> Could you please answer the following question:
> 
> Suppose we have a crypto filesystem on a raid1 array  of 2 devices. What will
> the kernel cache of fileystem data contain - encrypted data or not? Will is 
> be 2 copies of the same data in the cache or not?

Sorry for confusion - of course I meant linux software raid here..
 
> Is there any way to force kernel to cache the same file data only once, and
> keep it unencrypted (in cache)?
> 

-- 
 Best regards,
  -Vlad
