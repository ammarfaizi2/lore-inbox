Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbTDDT2i (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 14:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbTDDT2i (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 14:28:38 -0500
Received: from static-ctb-210-9-247-181.webone.com.au ([210.9.247.181]:24836
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S261165AbTDDT2h (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 14:28:37 -0500
Message-ID: <3E8DDF85.6010608@cyberone.com.au>
Date: Sat, 05 Apr 2003 05:39:49 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Joel Becker <Joel.Becker@oracle.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: WimMark I report for 2.5.66-mm3
References: <20030404191938.GN31739@ca-server1.us.oracle.com>
In-Reply-To: <20030404191938.GN31739@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:

>WimMark I report for 2.5.66-mm3 
>
>Runs (deadline):  1736.51 1681.50 1010.98
>Runs (antic):  579.62 496.75 517.06
>
For the moment AS has dropped a heuristih which previously seemed
to bring it to the 1000-1500 mark. That said it is still not up
to scratch on sync write benchmarks. I will work on this after
some generic block layer stuff gets in. Probably a week or two
away.

