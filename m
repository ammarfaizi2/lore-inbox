Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVADXHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVADXHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVADXG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:06:58 -0500
Received: from smtpout.mac.com ([17.250.248.89]:59099 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262397AbVADXEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 18:04:25 -0500
In-Reply-To: <Pine.LNX.4.60.0501041215500.9517@dlang.diginsite.com>
References: <1697129508.20050102210332@dns.toxicfilms.tv> <20050102203615.GL29332@holomorphy.com> <20050102212427.GG2818@pclin040.win.tue.nl> <Pine.LNX.4.61.0501031011410.25392@chimarrao.boston.redhat.com> <20050103153438.GF2980@stusta.de> <1104767943.4192.17.camel@laptopd505.fenrus.org> <20050104174712.GI3097@stusta.de> <Pine.LNX.4.60.0501041215500.9517@dlang.diginsite.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E6D1C846-5EA4-11D9-A816-000D9352858E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Andries Brouwer <aebr@win.tue.nl>
From: Felipe Alfaro Solana <lkml@mac.com>
Subject: Re: starting with 2.7
Date: Wed, 5 Jan 2005 00:03:52 +0100
To: David Lang <dlang@digitalinsight.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Jan 2005, at 21:18, David Lang wrote:

> Sorry, I've been useing kernel.org kernels since the 2.0 days and even 
> within a stable series I always do a full set of tests before 
> upgrading. every single stable series has had 'paper bag' releases, 
> and every single one has had fixes to drivers that have ended up 
> breaking those drivers.
>
> the only way to know if a new kernel will work on your hardware is to 
> try it. It doesn't matter if the upgrade is from 2.4.24 to 2.4.25 or 
> 2.6.9 to 2.6.10 or even 2.4.24 to 2.6.10
>
> anyone who assumes that just becouse the kernel is in the stable 
> series they can blindly upgrade their production systems is just 
> dreaming.

It's not a problem of blindly upgrading, but a problem of knowing that 
most of the kernel interfaces do remain stable to reduce the number of 
possible problems.

