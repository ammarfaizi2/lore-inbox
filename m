Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267260AbUBMWj2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 17:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267263AbUBMWj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 17:39:26 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:19745 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S267260AbUBMWhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 17:37:24 -0500
Date: Fri, 13 Feb 2004 17:37:21 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: yiding_wang@agilent.com
cc: linux-kernel@vger.kernel.org
Subject: Re: what is the best 2.6.2 kernel code?
In-Reply-To: <0A78D025ACD7C24F84BD52449D8505A15A80CF@wcosmb01.cos.agilent.com>
Message-ID: <Pine.LNX.4.44.0402131736170.26101-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Feb 2004 yiding_wang@agilent.com wrote:

> I downloaded kernel linux-2.6.2.tar.gz and patch-2.6.2.bz2 from kernel
> source.  Both files are dated 03-Feb.-2004.
> 
> Building new kernel from the source failed on fs/proc/array.o.  
> Patching with patch file will have numerous warning message which says
> "Reversed patch detected! Assume -R [n]".

linux-2.6.1 + patch-2.6.2 results in linux-2.6.2

If you download linux-2.6.2 you don't need to apply
any patches.

Please see http://www.kernelnewbies.org/

cheers,

Rik
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

