Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbVBKQ2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVBKQ2s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 11:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVBKQ2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 11:28:48 -0500
Received: from mtaout1.barak.net.il ([212.150.49.171]:33004 "EHLO
	mtaout1.barak.net.i") by vger.kernel.org with ESMTP id S262270AbVBKQ2q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 11:28:46 -0500
Date: Fri, 11 Feb 2005 18:29:22 +0200
From: Yuval Tanny <tanai@int.gov.il>
Subject: Re: 2.6.11-rc3-mm2
In-reply-to: <20050210023508.3583cf87.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <420CDD62.2070905@int.gov.il>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <20050210023508.3583cf87.akpm@osdl.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In fs/Kconfig,

See "Documentation/filesystems/fscache.txt for more information." and 
"See Documentation/filesystems/cachefs.txt for more information."

Should be changed to:

"See Documentation/filesystems/caching/fscache.txt for more 
information." and "See Documentation/filesystems/caching/cachefs.txt for 
more information."


Thanks,

Yuval


Andrew Morton wrote:

>cachefs-filesystem.patch
>  CacheFS filesystem
>  
>
