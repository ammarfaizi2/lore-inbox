Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270926AbTGVRAb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 13:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270929AbTGVRAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 13:00:31 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:10368 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270928AbTGVRAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 13:00:30 -0400
Date: Tue, 22 Jul 2003 18:14:09 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Kurt Roeckx <Q@ping.be>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org
Subject: Re: siginfo pad problem.
Message-ID: <20030722171409.GB3267@mail.jlokier.co.uk>
References: <20030721142259.GA4315@ping.be> <20030722022424.7480af8e.sfr@canb.auug.org.au> <20030721180032.GA26786@ping.be> <20030722095105.5ed2379a.sfr@canb.auug.org.au> <20030722170606.GA14680@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722170606.GA14680@ping.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Roeckx wrote:
> I'm still using libc5, and plan to do so for as long as I can.

That's fine.  Just install 2.4 kernel headers in /usr/include/linux
and /usr/include/asm.

-- Jamie

