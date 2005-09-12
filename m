Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbVILSCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVILSCE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbVILSCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:02:04 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:58098 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750804AbVILSCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:02:03 -0400
Message-ID: <4325C295.8040803@namesys.com>
Date: Mon, 12 Sep 2005 11:01:57 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jbeulich@novell.com
Subject: Re: [1/2] Make BUILD_BUG_ON fail at compile time.
References: <4322CBD8.mailE1M1FX8RR@suse.de> <20050910132202.GA877@infradead.org>
In-Reply-To: <20050910132202.GA877@infradead.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Sat, Sep 10, 2005 at 02:04:40PM +0200, Andi Kleen wrote:
>  
>
>>Make BUILD_BUG_ON fail at compile time.
>>
>>Force a compiler error instead of a link error, because they
>>are easier to track down. Idea stolen from code by Jan Beulich.
>>
>>Cc: jbeulich@novell.com
>>    
>>
>
>reiser4 seems to have a duplicate version of this, Hans, can you switch
>over to the common one once this is in?
>
>
>
>  
>
Yes we can.
