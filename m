Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbWBBTL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWBBTL5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 14:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWBBTL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 14:11:57 -0500
Received: from zcars04f.nortel.com ([47.129.242.57]:56545 "EHLO
	zcars04f.nortel.com") by vger.kernel.org with ESMTP
	id S1751044AbWBBTL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 14:11:56 -0500
Message-ID: <43E25976.6090109@nortel.com>
Date: Thu, 02 Feb 2006 13:11:50 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ian Kester-Haney <ikesterhaney@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
References: <Pine.LNX.4.40.0601280826160.29965-100000@jehova.dsm.dk>	 <200601302301.04582.brcha@users.sourceforge.net>	 <43E0E282.1000908@opersys.com>	 <Pine.LNX.4.64.0602011414550.21884@g5.osdl.org>	 <43E1C55A.7090801@drzeus.cx>	 <Pine.LNX.4.64.0602020044520.21884@g5.osdl.org>	 <1138891081.9861.4.camel@localhost.localdomain>	 <Pine.LNX.4.64.0602020814320.21884@g5.osdl.org>	 <43E23C79.8050606@drzeus.cx>	 <Pine.LNX.4.64.0602020937360.21884@g5.osdl.org>	 <441e43c90602021013j6edb2fa6m1142ef255040106d@mail.gmail.com> <1138906199.15691.54.camel@mindpipe>
In-Reply-To: <1138906199.15691.54.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Feb 2006 19:11:53.0127 (UTC) FILETIME=[86C38370:01C6282C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

> What nvidia is doing is already illegal under the GPLv2.

I don't think that's been legally proven.

The question is whether it is a derivative work.  If their driver core 
(aka the binary blob) is common to all their drivers (across multiple 
OS's), it could be argued that the binary blob itself is not a 
derivative work.  One could almost view it as firmware.

If they ship the binary blob as well as code that interfaces the binary 
blob with the kernel, and the end-user compiles the code together and 
loads it into the kernel, does that necessarily violate the GPL?

Chris

