Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbTJ0M3W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 07:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbTJ0M3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 07:29:21 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41663 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261683AbTJ0M3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 07:29:19 -0500
Date: Mon, 27 Oct 2003 04:22:58 -0800
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: ak@muc.de, simon.roscic@chello.at, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [2.6.0-test8/9] ethertap oops
Message-Id: <20031027042258.21446129.davem@redhat.com>
In-Reply-To: <20031027122635.GB16013@wotan.suse.de>
References: <L1fo.3gb.9@gated-at.bofh.it>
	<m3ekwz7h3z.fsf@averell.firstfloor.org>
	<20031026234828.2cb1f746.davem@redhat.com>
	<20031027122635.GB16013@wotan.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003 13:26:35 +0100
Andi Kleen <ak@suse.de> wrote:

> I don't know if it actually fixed the bug, I did not test it
> (sorry, should have stated that in the original mail)
> But at least it should printk now instead of crashing.

Ok, it's still an improvement over the blind dereferencing
it does not.
