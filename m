Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTLaKS0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 05:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbTLaKS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 05:18:26 -0500
Received: from mail4.bluewin.ch ([195.186.4.74]:16516 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S264147AbTLaKSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 05:18:25 -0500
Date: Wed, 31 Dec 2003 11:17:41 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Andy Isaacson <adi@hexapodia.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
Message-ID: <20031231101741.GA4378@k3.hellgate.ch>
Mail-Followup-To: Thomas Molina <tmolina@cablespeed.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Andy Isaacson <adi@hexapodia.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain> <20031230012551.GA6226@k3.hellgate.ch> <Pine.LNX.4.58.0312292031450.6227@localhost.localdomain> <20031230132145.B32120@hexapodia.org> <20031230194051.GD22443@holomorphy.com> <20031230222403.GA8412@k3.hellgate.ch> <Pine.LNX.4.58.0312301921510.3193@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312301921510.3193@localhost.localdomain>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Dec 2003 19:33:06 -0500, Thomas Molina wrote:
> If I am understanding you, you would like data on 2.5.27, 2.5.38, and 
> 2.5.39.  I'll do it if it will help something.  I'll look at it in the 

Thanks. 2.5.39 alone will do, actually. I'm just curious how far the
similarity between qsbench and bk export goes.

Roger
