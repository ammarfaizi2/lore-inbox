Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269404AbUHZTDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269404AbUHZTDG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269373AbUHZS6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:58:48 -0400
Received: from holomorphy.com ([207.189.100.168]:16536 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269388AbUHZS5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:57:11 -0400
Date: Thu, 26 Aug 2004 11:56:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@lst.de>,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826185655.GF2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@lst.de>,
	viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>,
	Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
References: <20040824202521.GA26705@lst.de> <412BA741.4060006@pobox.com> <20040824205343.GE21964@parcelfarce.linux.theplanet.co.uk> <20040824212232.GF21964@parcelfarce.linux.theplanet.co.uk> <412CDA68.7050702@namesys.com> <20040825184523.GA15419@lst.de> <412DA725.4040200@namesys.com> <20040826183838.GE2793@holomorphy.com> <Pine.LNX.4.58.0408261147590.2304@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408261147590.2304@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, William Lee Irwin III wrote:
>> +N: Hans Reiser
>> +E: reiser@namesys.com
>> +W: http://www.namesys.com/
>> +D: official Linux kernel hairstyle critic
>> +S: 6979 Exeter Dr
>> +S: Oakland, CA 94611
>> +S: USA

On Thu, Aug 26, 2004 at 11:49:19AM -0700, Linus Torvalds wrote:
> LOL.
> In all fairness, how _would_ you have described it?
> Besides, I don't think this should go in the CREDITS file, since hair 
> styling criticism is clearly an ongoing MAINTAINERS issue, no?

As far as maintenance goes, absolutely. As far as describing it goes,
I probably would have said it was short, red, and spiky.


Index: mm1-2.6.9-rc1/MAINTAINERS
===================================================================
--- mm1-2.6.9-rc1.orig/MAINTAINERS	2004-08-26 10:38:09.867927190 -0700
+++ mm1-2.6.9-rc1/MAINTAINERS	2004-08-26 11:58:27.759469733 -0700
@@ -1352,6 +1352,12 @@
 L:	linuxppc64-dev@lists.linuxppc.org
 S:	Supported
 
+LINUX KERNEL HAIRSTYLE CRITICISM
+P: Hans Reiser
+M: reiser@namesys.com
+W: http://www.namesys.com/
+S: Maintained
+
 LINUX SECURITY MODULE (LSM) FRAMEWORK
 P:	Chris Wright
 M:	chrisw@osdl.org
