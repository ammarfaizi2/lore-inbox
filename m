Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263891AbTLASoG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 13:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbTLASoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 13:44:06 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:13327
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263891AbTLASoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 13:44:04 -0500
Date: Mon, 1 Dec 2003 10:43:57 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <piggin@cyberone.com.au>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: amanda vs 2.6
Message-ID: <20031201184357.GI1566@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <200311261212.10166.gene.heskett@verizon.net> <200311270505.50242.gene.heskett@verizon.net> <20031127133929.GX8039@holomorphy.com> <200311291214.33130.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311291214.33130.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 29, 2003 at 12:14:33PM -0500, Gene Heskett wrote:
> Another data point about this, still unsolved problem:
> 
> The number of times I can do an 'su amanda' then exit, and redo the it 
> seem to be somewhat random,  One test I managed to get to the 4th su 

Did you try to 'strace su amanda'?

What version of glibc are you running?

What distro and version?
