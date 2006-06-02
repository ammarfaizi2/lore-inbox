Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWFBViq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWFBViq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 17:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWFBVip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 17:38:45 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:35290 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751487AbWFBVip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 17:38:45 -0400
Message-ID: <4480AFD7.8070508@us.ibm.com>
Date: Fri, 02 Jun 2006 14:38:31 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org, hch@lst.de,
       Zach Brown <zach.brown@oracle.com>, cel@citi.umich.edu
Subject: Re: [PATCH 0/4] VFS fileop cleanups by collapsing AIO and vector IO	(2.6.17-rc5-mm2)
References: <1149275193.26170.8.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Badari Pulavarty wrote:

>Hi Andrew,
>
>Here is the updated set of patches for 2.6.17-rc5-mm2 with
>autofs fixes. Ian and I verified with autofs tests and also
>running on Fedora Core 5. 
>

Correction !! I tested these series of patches (heavily) on mainline 
2.6.17-rc5 and
then ported to current -mm. -mm2 is not really stable enough for me yet, 
running into
 few issues. I will continue to test these on -mm also.

Thanks,
Badari



