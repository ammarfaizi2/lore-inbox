Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267636AbUHELGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267636AbUHELGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 07:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267640AbUHELGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 07:06:43 -0400
Received: from legaleagle.de ([217.160.128.82]:8093 "EHLO www.legaleagle.de")
	by vger.kernel.org with ESMTP id S267636AbUHELDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 07:03:47 -0400
Message-ID: <411214A6.9000906@trash.net>
Date: Thu, 05 Aug 2004 13:06:14 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: prasanna@in.ibm.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, ak@muc.de, akpm@osdl.org,
       suparna@in.ibm.com
Subject: Re: [2/3] kprobes-netfilter-268-rc3.patch
References: <20040805100227.GB2303@in.ibm.com>
In-Reply-To: <20040805100227.GB2303@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prasanna S Panchamukhi wrote:

>Hi,
>
>Below  is the [2/3] kprobes-netfilter-268-rc3.patch.
>This patche includes changes to export the dump_packet routine.
>  
>
Why aren't you using the exported logging interface, nf_log_packet ?

Regards
Patrick

