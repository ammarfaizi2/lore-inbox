Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbUCOLwG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 06:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbUCOLwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 06:52:06 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:15881 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262537AbUCOLwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 06:52:03 -0500
Date: Mon, 15 Mar 2004 14:51:45 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4 on Alpha uninterruptible sleep of processes
Message-ID: <20040315145145.A31703@jurassic.park.msu.ru>
References: <20040312154613.7567adab@hdg.gigerstyle.ch> <20040312182754.A680@jurassic.park.msu.ru> <20040312184115.B680@jurassic.park.msu.ru> <20040312165907.626d4a08@hdg.gigerstyle.ch> <20040312224649.A750@den.park.msu.ru> <20040312215215.1041889a@hdg.gigerstyle.ch> <20040313020141.B4021@den.park.msu.ru> <20040313111021.4af73b9e@hdg.gigerstyle.ch> <20040314170627.A11159@den.park.msu.ru> <20040314195203.78abbef9@vaio.gigerstyle.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040314195203.78abbef9@vaio.gigerstyle.ch>; from gigerstyle@gmx.ch on Sun, Mar 14, 2004 at 07:52:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2004 at 07:52:03PM +0100, Marc Giger wrote:
> No, it doesn't. After some hours it has got the same problems.

Fine, at least semaphores changes are innocent. :-)

Interesting - I wasn't able to reproduce these problems with
recent kernels on my boxes (including one lx164)...

Ivan.
