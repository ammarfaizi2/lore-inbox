Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbVI1Q7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbVI1Q7l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 12:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVI1Q7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 12:59:41 -0400
Received: from magic.adaptec.com ([216.52.22.17]:16838 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1751304AbVI1Q7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 12:59:40 -0400
Message-ID: <433ACBEF.9040006@adaptec.com>
Date: Wed, 28 Sep 2005 12:59:27 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Moore, Eric Dean" <Eric.Moore@lsil.com>
CC: ltuikov@yahoo.com, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 	 the kernel
References: <91888D455306F94EBD4D168954A9457C04388439@nacos172.co.lsil.com>
In-Reply-To: <91888D455306F94EBD4D168954A9457C04388439@nacos172.co.lsil.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2005 16:59:36.0918 (UTC) FILETIME=[01F3DF60:01C5C44E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/05 11:15, Moore, Eric Dean wrote:
> Luben: I guess you didn't get what I meant.
> 
> I was referring that there are other
> *vendors* (not LSI, e.g MegaRAID) that are 
> working on sas solutions with sas firmware 
> implementation. One that comes to mind is
> Intel SunRise Lake, which is non a MPT based 
> solution, that would work with Christophs 
> Sas Layer. There maybe others, such as emulex.
> Perhaps James S. could comment on that.

This means that they have an IOP on the same
silicone or on the same packaging.

This means, again that they'd done all transport
specific tasks in the FW (by the IOP).

Again, such solutions do _not_ need the
SAS Transport Layer.

They don't even need the attributes, but
as a "nice to have" feature, you can use
transport attributes.

You, as technical person, should recognize
the different needs and thus the different
solutions between LSI's implementation and
Adaptec's.

I'm surprised you never chimed in in defense
of the _different_ technology.

See, I've mentioned many times that the two
radically different technologies can coexist.
But I've not heard any technical word
from the other guys: you.

	Luben
