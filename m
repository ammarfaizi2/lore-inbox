Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262937AbVAKWtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbVAKWtu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262938AbVAKWtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:49:32 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:48024 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262919AbVAKWrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:47:00 -0500
Date: Tue, 11 Jan 2005 15:46:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: James Nelson <james4765@cwazy.co.uk>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: Re: [RESEND] [PATCH 0/7] ppc: remove cli()/sti() from arch/ppc/*
Message-ID: <20050111224649.GO3391@smtp.west.cox.net>
References: <20050108170406.32690.36989.11853@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050108170406.32690.36989.11853@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 11:03:49AM -0600, James Nelson wrote:

> This series of patches is to remove the last cli()/sti() function calls in
> arch/ppc, and add spinlocks where necessary.

I'll push this to Andrew and hope they move from there, thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
