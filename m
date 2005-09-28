Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbVI1PP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbVI1PP4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 11:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbVI1PPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 11:15:55 -0400
Received: from mail0.lsil.com ([147.145.40.20]:3767 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751023AbVI1PPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 11:15:55 -0400
Message-ID: <91888D455306F94EBD4D168954A9457C04388439@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: ltuikov@yahoo.com, Luben Tuikov <luben_tuikov@adaptec.com>,
       Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: RE: I request inclusion of SAS Transport Layer and AIC-94xx into 
	 the kernel
Date: Wed, 28 Sep 2005 09:15:41 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, September 28, 2005 5:42 AM, Luben Tuikov wrote:
> > Hi Luben,
> > 
> > OK, Man are you alright?
> > 
> > I've heard of other vendors planning to 
> > provide solutions where sas is implemented
> > in firmware, similar to MPT.  Christophs
> > sas layer is going to work with other 
> > solutions, don't think of it being 
> > MPT centric.
> 
> Where in what I said above do I say that it will _not_
> work with _other_ MPT based drivers?  Nowhere!
> 
> Yes it _will_ work with other MPT-like drivers but
> to cut and paste again from above:
>  * MPT based only,
>  * doesn't follow a spec to save its life,
>  * far inferior in SAS capabilities and SAS representation
>    again, due to the fact that it is MPT based.
> 
> When I say MPT, I do not mean MPT(R), I mean MPT as
> in technology, not as in trademark.
> 
>      Luben
> 

Luben: I guess you didn't get what I meant.

I was referring that there are other
*vendors* (not LSI, e.g MegaRAID) that are 
working on sas solutions with sas firmware 
implementation. One that comes to mind is
Intel SunRise Lake, which is non a MPT based 
solution, that would work with Christophs 
Sas Layer. There maybe others, such as emulex.
Perhaps James S. could comment on that.

Eric




