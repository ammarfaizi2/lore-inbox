Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbTJCHkv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 03:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263599AbTJCHku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 03:40:50 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:57262
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S263596AbTJCHks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 03:40:48 -0400
Date: Fri, 3 Oct 2003 09:41:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Mathias Kretschmer <mathias@lemur.sytes.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre6aa1
Message-ID: <20031003074108.GJ13360@velociraptor.random>
References: <20031002152648.GB1240@velociraptor.random> <3F7CBE38.8000908@lemur.sytes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F7CBE38.8000908@lemur.sytes.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 02, 2003 at 08:09:28PM -0400, Mathias Kretschmer wrote:
> I'm getting the below errors compiling the bttv module.
> 
> Also, the commercial OSS sound driver fails to compile against it.
> It compiled under -pre6.
> 
> Otherwise, it seems to work fine for me.
> 
> Let me know, if you need any further info.

did you configure pre6 mainline with CONFIG_FW_LOADER = y ?

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
