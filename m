Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275232AbTHGIaK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 04:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275234AbTHGIaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 04:30:10 -0400
Received: from dyn-ctb-203-221-72-79.webone.com.au ([203.221.72.79]:13075 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S275232AbTHGIaH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 04:30:07 -0400
Message-ID: <3F320DFC.6070400@cyberone.com.au>
Date: Thu, 07 Aug 2003 18:29:48 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test2-mm5
References: <20030806223716.26af3255.akpm@osdl.org>	<28050000.1060237907@[10.10.2.4]> <20030807000542.5cbf0a56.akpm@osdl.org>
In-Reply-To: <20030807000542.5cbf0a56.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
>>I get lots of these .... (without 4/4 turned on)
>>
>>  Badness in as_dispatch_request at drivers/block/as-iosched.c:1241
>>
>
>yes, it happens with aic7xxx as well.  Sorry about that.
>
>You'll need to revert 
>
>

Sorry. Worked with the sym53c8xx for me. I'll fix.


