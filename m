Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbTKLXJt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 18:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbTKLXJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 18:09:48 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:51873 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261692AbTKLXJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 18:09:37 -0500
Message-ID: <3FB214F2.2020806@namesys.com>
Date: Wed, 12 Nov 2003 03:09:38 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@colin2.muc.de>
CC: Peter Chubb <peter@chubb.wattle.id.au>, Andi Kleen <ak@muc.de>,
       Bernd Schubert <Bernd.Schubert@tc.pci.uni-heidelberg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2 TB partition support
References: <QugF.3Mq.7@gated-at.bofh.it> <Qwit.771.11@gated-at.bofh.it> <QR40.39P.53@gated-at.bofh.it> <m3d6bybeiw.fsf@averell.firstfloor.org> <16306.35809.15450.378197@wombat.chubb.wattle.id.au> <20031112222609.GA2924@colin2.muc.de>
In-Reply-To: <20031112222609.GA2924@colin2.muc.de>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>>Has the kmalloc problem in Reiserfs gone away?  It used to be that the
>>limit for a Reiser filesystem was determined by how many pointers
>>could fit into a kmalloced chunk of memory;
>>
?  I am not familiar with this....

>> thus the 64-bit system
>>limit was half teh 32-bit system limit.
>>    
>>
>
>I don't know. i haven't tested reiserfs (or any other fs) with big file 
>systems.
>
>I was just talking about the theoretic limits in the block layer.
>
>-Andi
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>


-- 
Hans


