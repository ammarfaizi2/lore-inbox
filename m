Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264211AbUD0R2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264211AbUD0R2q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 13:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUD0R2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 13:28:46 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:49291 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264211AbUD0R2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 13:28:40 -0400
Message-ID: <408E986F.90506@namesys.com>
Date: Tue, 27 Apr 2004 10:29:19 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Chris Mason <mason@suse.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com, akpm@osdl.org
Subject: Re: I oppose Chris and Jeff's patch to add an unnecessary additional
 namespace to ReiserFS
References: <1082750045.12989.199.camel@watt.suse.com> <408D3FEE.1030603@namesys.com> <20040426203314.A6973@infradead.org>
In-Reply-To: <20040426203314.A6973@infradead.org>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Christoph Hellwig wrote:

>On Mon, Apr 26, 2004 at 09:59:26AM -0700, Hans Reiser wrote:
>  
>
>>The xattr namespace offers zero functional advantage over the file 
>>namespace.  The use of '.' instead of '/' is idiotic, see the very short 
>>paper "The Hideous Name" by Rob Pike  ( www.cs.bell-labs.com/cm/cs/doc/ 
>>) for why mindlessly varying the separators in hierarchical names 
>>throughout an OS is a bad idea. 
>>    
>>
>
>Hans, where have you been the last three years?  Hiding under a rock?
>
>  
>

>As for ACLs in v3 that's a decision of the maintainer, currently you're
>the formal maintainer, but I don't remember a single patch from you.
>Most of the linux 2.6 work has been done by Chris and quite a bit of
>work by your employees.  Chris is paid for doing a stable and working
>reiserfs variant for SuSE so he seems to be qualified for doing that, to..
>  
>
Did you notice that V4 blows XFS and ReiserFS V3 away in benchmarks?    
That is what I have been doing for 3 years....

See www.namesys.com for details.
