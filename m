Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVEZTit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVEZTit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 15:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVEZTgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 15:36:10 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:39817 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261718AbVEZTfs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 15:35:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=A+4DPBNdGltmxOAatoeaD1EIo+T4pLHEhs8Gg9ywXCwcmyL3ZcMhgiYsisbadqA2fFB0u+C0grWEHLXXBTVTLJYZ4NluBPvnSfx8b+Crv9ZJ+zevzZvyLIrjne5v6ZR63jrlXnv/WdVMtpiO77bWXz6pA0F0pbpqx3I7MGgLijA=
Message-ID: <a44ae5cd0505261235fc05313@mail.gmail.com>
Date: Thu, 26 May 2005 15:35:47 -0400
From: Miles Lane <miles.lane@gmail.com>
Reply-To: Miles Lane <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc5 build failure
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
>
> Fixed in 2.6.12-rc5-dca79a046b93a81496bb30ca01177fb17f37ab72.
> 
> http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdif \
> f;h=dca79a046b93a81496bb30ca01177fb17f37ab72;hp=5daf05fbf73fc199e7a93a818e504856d07c55  \
> 86

Why does the GitWeb interface lack a link to have a patch saved as a
text file?  Cutting and pasting isn't working for me with this patch. 
Also, saving the webpage as text from Firefox 1.0.4 also fails to give
me a working patch.

I get this patch error:

patching file drivers/char/ipmi/ipmi_devintf.c
patch: **** malformed patch at line 4: " interface. Other values will
set the major device number"

What's up with this?

Thanks,
            MIles
