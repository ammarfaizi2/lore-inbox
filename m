Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUBLQUf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 11:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266508AbUBLQUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 11:20:35 -0500
Received: from ns.suse.de ([195.135.220.2]:10170 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266514AbUBLQUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 11:20:31 -0500
Date: Fri, 13 Feb 2004 04:00:41 +0100
From: Andi Kleen <ak@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, amitkale@emsyssoft.com
Subject: Re: [PATCH][6/6] A different KGDB stub
Message-Id: <20040213040041.3e1ec2c2.ak@suse.de>
In-Reply-To: <20040212155055.GN19676@smtp.west.cox.net>
References: <20040212000408.GG19676@smtp.west.cox.net.suse.lists.linux.kernel>
	<p73wu6syf0n.fsf@verdi.suse.de>
	<20040212155055.GN19676@smtp.west.cox.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Feb 2004 08:50:55 -0700
Tom Rini <trini@kernel.crashing.org> wrote:


> 
> Part of why I'm trying to get this into -mm is so that someone who has
> the hw and knowledge can try and merge some of the things that the other
> stubs got right into the stub that every arch can use.

The kgdb stub in current -mm* does all the things I mentioned correctly.

-Andi
