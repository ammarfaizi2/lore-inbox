Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266616AbUBFGc4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 01:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266648AbUBFGcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 01:32:55 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:15020 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266616AbUBFGcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 01:32:53 -0500
Message-ID: <40233504.5020607@colorfullife.com>
Date: Fri, 06 Feb 2004 07:32:36 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: Limit hash table size
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:

>Maybe we should leave the sizing of these tables as-is, and add some hook
>which allows the architecture to scale them back.
>  
>
Architecture or administrator?
I think a boot parameter is the better solution: The admin knows if his 
system is a compute node or a file server.

--
    Manfred


