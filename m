Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265994AbUBCMvm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 07:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265995AbUBCMvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 07:51:42 -0500
Received: from [216.218.244.58] ([216.218.244.58]:52708 "EHLO
	www.kerneltrap.org") by vger.kernel.org with ESMTP id S265994AbUBCMvl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 07:51:41 -0500
Date: Tue, 3 Feb 2004 07:51:18 -0500
From: Jeremy Andrews <jeremy@kerneltrap.org>
To: Markus =?ISO-8859-1?B?SORzdGJhY2th?= <midian@ihme.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.6.2-rc3
Message-Id: <20040203075118.2dd12a4a.jeremy@kerneltrap.org>
In-Reply-To: <1075755810.15169.4.camel@midux>
References: <20040202201411.GA19268@home.kerneltrap.org>
	<1075755810.15169.4.camel@midux>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Feb 2004 23:03:30 +0200
Markus Hästbacka <midian@ihme.org> wrote:

> I heard that the PREEMPT is causing problems, earlier, try without
> CONFIG_PREEMPT

Indeed the machine appears stable without PREEMPT at the moment, though I
also made other configuration changes as well.  I'll keep adding back
things I need one by one to see if the instability returns / which causes
it.

> Could you please describe what the server is serving (router or
> something else?)

It's my primary desktop computer (so I certainly hope that PREEMPT is not
triggering the problem).

Cheers,
 -Jeremy
