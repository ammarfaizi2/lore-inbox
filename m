Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263899AbTAaXd0>; Fri, 31 Jan 2003 18:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbTAaXd0>; Fri, 31 Jan 2003 18:33:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24590 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263899AbTAaXdY>;
	Fri, 31 Jan 2003 18:33:24 -0500
Message-ID: <3E3B0978.7080900@pobox.com>
Date: Fri, 31 Jan 2003 18:40:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: Perl in the toolchain
References: <20030131133929.A8992@devserv.devel.redhat.com> <Pine.LNX.4.44.0301311327480.16486-100000@chaos.physics.uiowa.edu> <20030131194837.GC8298@gtf.org> <20030131213827.GA1541@werewolf.able.es> <3E3B066B.8010905@pobox.com> <20030131234021.GE1541@werewolf.able.es>
In-Reply-To: <20030131234021.GE1541@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> As someone said, parsing and string processing is one of the jobs in kernel
> config. Kernel gurus decided to rewrite the thing in C to avoid the lacks
> in the current bash-ish kconfig, because writing logic for dependencies,
> checks and so on is a pain...so let's rewrite the logic handling, _and_ the
> string processing, btw.
> The easies way (from my point of view): write Perl::KConfig in C to do the logic
> hard work and build the big thing in perl. That will be putting a perl
> interface on top of klibc ?


_Any_ rewrite is pure pedantry and useless work.

