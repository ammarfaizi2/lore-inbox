Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVCSPKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVCSPKS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 10:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbVCSPKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 10:10:18 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:65287 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261516AbVCSPKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 10:10:10 -0500
Date: Sat, 19 Mar 2005 16:09:59 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.30-rc1
Message-ID: <20050319150959.GG30052@alpha.home.local>
References: <20050318215513.GA25936@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318215513.GA25936@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

2.4.30-rc1 works fine here on athlon-SMP and sparc64-smp. BTW, the athlon
uses the e1000 driver (which has been updated since 2.4.29) with no trouble
at all.

I'll post a 2.4.29-hf5 in a few hours, just the time to put the thing online,
it already builds on the same machines.

Cheers,
Willy

