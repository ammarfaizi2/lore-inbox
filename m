Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265442AbTLHPgx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 10:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265424AbTLHPgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 10:36:53 -0500
Received: from holomorphy.com ([199.26.172.102]:39643 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265440AbTLHPgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 10:36:49 -0500
Date: Mon, 8 Dec 2003 07:36:41 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Per Buer <perbu@linpro.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4: mylex and > 2GB RAM
Message-ID: <20031208153641.GJ8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Per Buer <perbu@linpro.no>, linux-kernel@vger.kernel.org
References: <1070897058.25490.56.camel@netstat.linpro.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070897058.25490.56.camel@netstat.linpro.no>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 04:24:19PM +0100, Per Buer wrote:
> I have an Supermicro Superserver (wow!) 8040 or 8060 with a two Intel
> Xeon (p3-based with 1MB cache) and a Mylex AcceleRAID 352. We recently
> upgraded from 2 to 4GB of memory.
> There seems to a problem with IO and high memory. Suddenly IO
> performance will degrade dramatically (throughput of about 50KB/s).
> Booting the machine with "mem=2048" remedies this.
> We have tried replacing the memory with another make - no luck.
> Any hints?

Could you send out a dmesg and a config file?


-- wli
