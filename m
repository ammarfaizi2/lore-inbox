Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbTEBQxH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 12:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbTEBQxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 12:53:06 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:27921 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263019AbTEBQxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 12:53:06 -0400
Date: Fri, 2 May 2003 19:05:28 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
Message-ID: <20030502170528.GC29245@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0305021217090.17548-100000@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305021217090.17548-100000@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 May 2003, Ingo Molnar wrote:

> We are pleased to announce the first publically available source code
> release of a new kernel-based security feature called the "Exec Shield",
> for Linux/x86. The kernel patch (against 2.4.21-rc1, released under the
> GPL/OSL) can be downloaded from:

Am I the only one under the impression that this looks as though this
had waited for OpenBSD 3.3 to say "Blbrrrrrrrrp! we're first to have
stack protection in the kernel and don't need to hack gcc." (Their W^X
isn't enabled on the i386 architecture, but is due (on i386) in 3.4.)
