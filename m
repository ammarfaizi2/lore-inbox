Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267466AbUIWXDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267466AbUIWXDK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 19:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267535AbUIWWzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 18:55:44 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:1706 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S267517AbUIWWw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 18:52:29 -0400
Date: Fri, 24 Sep 2004 00:52:21 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: "David S. Miller" <davem@davemloft.net>
Cc: yoshfuji@linux-ipv6.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: ArcNet and 2.6.8.1
In-Reply-To: <20040923152411.1d1a08d2.davem@davemloft.net>
Message-Id: <Pine.OSF.4.05.10409240033480.21511-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And I only want to explain why you don't see ArcNet used much with Linux
:-)

Oh well, I'll try to see if I can get time to make it stable with
preemption on. Is preemption safe enough to ensure SMP safe or would I
have to test on at least a hyperthreading machine as well?

Esben


On Thu, 23 Sep 2004, David S. Miller wrote:

> 
> I have not argued the technical pros and cons of arcnet.
> 
> I have merely stated that since you are the first person
> reporting the OOPS, it is indicative that not many people
> are testing arcnet in the 2.6.x kernel.
> 


