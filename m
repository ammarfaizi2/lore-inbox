Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUG0LK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUG0LK7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 07:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUG0LK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 07:10:58 -0400
Received: from mail1.slu.se ([130.238.96.11]:65183 "EHLO mail1.slu.se")
	by vger.kernel.org with ESMTP id S263743AbUG0LK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 07:10:56 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16646.14381.740376.204381@robur.slu.se>
Date: Tue, 27 Jul 2004 13:10:37 +0200
To: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       Francois Romieu <romieu@fr.zoreil.com>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <netdev@oss.sgi.com>, <brad@brad-x.com>, <shemminger@osdl.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <Pine.LNX.4.44.0407270304570.11416-100000@silmu.st.jyu.fi>
References: <16645.34772.760879.146784@robur.slu.se>
	<Pine.LNX.4.44.0407270304570.11416-100000@silmu.st.jyu.fi>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pasi Sjoholm writes:

 > First run:
 > timestamp diff = 0, maxlat = 4581159

 Yes you starved your user apps for ~5 sec. 
 
 Any idea where your load comes from? Pure NFS network load cannot be hard.
 
 Cheers.
						--ro
