Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268741AbTCAQBn>; Sat, 1 Mar 2003 11:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268758AbTCAQBn>; Sat, 1 Mar 2003 11:01:43 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20374
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268741AbTCAQBm>; Sat, 1 Mar 2003 11:01:42 -0500
Subject: Re: anticipatory scheduling questions
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Lang <david.lang@digitalinsight.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303010350180.17904-100000@dlang.diginsite.com>
References: <Pine.LNX.4.44.0303010350180.17904-100000@dlang.diginsite.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046538908.23347.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 01 Mar 2003 17:15:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-01 at 11:51, David Lang wrote:
> wasn't there something about Evolution having problems with the change to
> child-runs-first-on-fork logic several months ago?

There was a problem with a bug in the AF_UNIX socket layer causing evolution
to fail. I don't remember a fork based one. Its quite possible there is

