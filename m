Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265228AbTLFTBT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 14:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbTLFTBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 14:01:19 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:60316 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S265228AbTLFTBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 14:01:18 -0500
Date: Sat, 06 Dec 2003 11:01:10 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched-HT-2.6.0-test11-A5
Message-ID: <392900000.1070737269@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.58.0312011102540.3323@earth>
References: <20031117021511.GA5682@averell><3FB83790.3060003@cyberone.com.au><20031117141548.GB1770@colin2.muc.de><Pine.LNX.4.56.0311171638140.29083@earth><20031118173607.GA88556@colin2.muc.de><Pine.LNX.4.56.0311181846360.23128@earth><20031118235710.GA10075@colin2.muc.de><3FBAF84B.3050203@cyberone.com.au><501330000.1069443756@flay><3FBF099F.8070403@cyberone.com.au><1010800000.1069532100@[10.10.2.4]><3FC01817.3090705@cyberone.com.au><3FC0A0C2.90800@cyberone.com.au><Pine.LNX.4.56.0311231300290.16152@earth> <1027750000.1069604762@[10.10.2.4]> <Pine.LNX.4.58.0312011102540.3323@earth>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> i've uploaded the HT scheduler patch against 2.6.0-test11 to:
> 
>     redhat.com/~mingo/O(1)-scheduler/sched-HT-2.6.0-test11-A5

Hangs on boot (NUMA-Q) after "Starting migration thread for cpu 0".
Any ideas what that might be?

M.

