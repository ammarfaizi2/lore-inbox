Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbVIQKwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbVIQKwe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 06:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbVIQKwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 06:52:34 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:43907 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1751057AbVIQKwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 06:52:34 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Date: Sat, 17 Sep 2005 13:51:57 +0300
User-Agent: KMail/1.8.2
Cc: Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@infradead.org>,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
References: <432AFB44.9060707@namesys.com> <432B1F84.3000902@namesys.com> <1C909C65-8B71-4817-AE13-519599D0B11A@mac.com>
In-Reply-To: <1C909C65-8B71-4817-AE13-519599D0B11A@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509171351.57152.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 September 2005 22:52, Kyle Moffett wrote:
> [CC list trimmed to relevant people, no need to spam Linus' and  
> Andrew's mailboxes, they have enough to do as it is]
> 
> On Sep 16, 2005, at 15:39:48, Hans Reiser wrote:
> > Christoph Hellwig wrote:
> >> additinoal comment is that the code is very messy, very different
> >> from normal kernel style, full of indirections and thus hard to read.
> >
> > Most of my customers remark that Namesys code is head and shoulders
> > above the rest of the kernel code.  So yes, it is different.
> 
> And yet thousands and thousands of people, businesses, etc, say that  
> the Linux kernel code is miles above all the commercial software out  
> there. Please leave the worthless rhetoric out of a technical  
> discussion.  The issue stands that in many ways the Reiser4 code does  
> not exactly follow Documentation/CodingStyle and does not match most  
> of the rest of the kernel, making it hard to read for other kernel  
> developers.  If you were just doing this forever as an external  
> kernel patch, nobody would give a damn.  On the other hand, you're  
> trying to get it included in the upstream kernel, which means that  
> those same "other kernel developers" for whom it is hard to read may  
> be expected to maintain it until the end of time.  Given this, it  
> seems perfectly reasonable to ask that it be cleaned up.

I think it makes sense to supply examples from reiser4 code
which you want to be changed. "It's ugly" is not specific enough.
--
vda
