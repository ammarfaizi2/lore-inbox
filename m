Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319323AbSIFSm1>; Fri, 6 Sep 2002 14:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319324AbSIFSm1>; Fri, 6 Sep 2002 14:42:27 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:49349 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319323AbSIFSmF>; Fri, 6 Sep 2002 14:42:05 -0400
Date: Fri, 06 Sep 2002 11:45:17 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: "David S. Miller" <davem@redhat.com>, haveblue@us.ibm.com
cc: ak@suse.de, hadi@cyberus.ca, tcw@tempest.prismnet.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
Message-ID: <61557945.1031312716@[10.10.2.3]>
In-Reply-To: <20020906.113652.40767574.davem@redhat.com>
References: <20020906.113652.40767574.davem@redhat.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    Actually, oprofile separated out the acenic module from the rest of the 
>    kernel.  I should have included that breakout as well. but it was only 1.3 
>    of CPU:
>    1.3801 0.0000 /lib/modules/2.4.18+O1/kernel/drivers/net/acenic.o
> 
> We thought you were using e1000 in these tests?

e1000 on the server, those profiles were client side.

M.

