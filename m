Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTKRNmX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbTKRNmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:42:23 -0500
Received: from ns.suse.de ([195.135.220.2]:59345 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262652AbTKRNmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:42:16 -0500
To: Samuel Flory <sflory@rackable.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre8 x86-64 compile failure APCI related
References: <3FA2C44C.5040205@rackable.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 01 Nov 2003 19:47:45 +0100
In-Reply-To: <3FA2C44C.5040205@rackable.com.suse.lists.linux.kernel>
Message-ID: <p73k76k7woe.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Flory <sflory@rackable.com> writes:


> : undefined reference to `acpi_pic_set_level_irq'

Already fixed in Marcelo's tree.

> make: *** [vmlinux] Error 1
> 
> 
> 
> PS- Is there an amd64 tree somewhere like the PPC tree?

CVS tree on cvs.x86-64.org. See http://www.x86-64.org for details. 

-Andi

