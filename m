Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268427AbUHLG7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268427AbUHLG7D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 02:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268428AbUHLG7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 02:59:03 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:50704 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id S268427AbUHLG7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 02:59:00 -0400
Message-ID: <411B1551.4050204@hp.com>
Date: Thu, 12 Aug 2004 12:29:29 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040808 Debian/1.7.2-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
Cc: Zenaan Harkness <zen@freedbms.net>, linux-kernel@vger.kernel.org
Subject: Re: vservers on OpenMosix ??
References: <fa.e7rnl7c.l0smqm@ifi.uio.no> <fa.ptfdr34.11kiiia@ifi.uio.no>
In-Reply-To: <fa.ptfdr34.11kiiia@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Thu, 12 Aug 2004, Zenaan Harkness wrote:
> 
> 
>>Is anyone doing this? Is it possible?
> 
> 
> It might be possible, but is probably quite a lot of work.
> 
> 
>>Wouldn't it be the ultimate clustering solution?
> 
> 
> Not if MOSIX still has the problem that when one machine
> crashes, you lose all the processes that started on that
> system or have any services running on that system.
> 
> Also, IPC across the network isn't very fast, so it may
> be better for performance if all the processes from a
> single virtual system run on one physical system...
> 

There you explained some of the things that OpenSSI(www.openssi.org) 
does :).

-aneesh
