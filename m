Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbUKWTew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbUKWTew (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 14:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbUKWTc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:32:56 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:37610 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261504AbUKWTcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:32:16 -0500
Message-ID: <41A3903D.3060208@candelatech.com>
Date: Tue, 23 Nov 2004 11:32:13 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Drivers For Multi-Port Nic Question
References: <Pine.LNX.4.61.0411230822170.3740@p500> <41A37AF0.3000207@candelatech.com> <Pine.LNX.4.61.0411231315470.3740@p500>
In-Reply-To: <Pine.LNX.4.61.0411231315470.3740@p500>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> The manufacturer and model of this ethernet card is:
> 
> An Adaptec ANA-6944A/TX NIC 10/100 Quad-port Ethernet Card.

I had one of those once..never got it to work.  If you can get
a new card, I'd suggest a p430tx or a 4-port Intel pro/1000
GigE NIC.  (The latter is 'only' $400 or so.)

If you can find an old DFE 570tx Dlink 4-port NIC those work
good too..but are discontinued for several years now.

Be careful about cheap Intel pro/100 4-port NICs..there are some
that will not negotiate link correctly.

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

