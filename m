Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbUJWX5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbUJWX5L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 19:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbUJWX5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 19:57:11 -0400
Received: from cantor.suse.de ([195.135.220.2]:26856 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261338AbUJWX5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 19:57:06 -0400
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Writing linux kernel specification
References: <Pine.LNX.4.44.0410231118570.25612-100000@chimarrao.boston.redhat.com.suse.lists.linux.kernel>
	<417AE4EA.6070107@bigpond.net.au.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 24 Oct 2004 01:56:11 +0200
In-Reply-To: <417AE4EA.6070107@bigpond.net.au.suse.lists.linux.kernel>
Message-ID: <p73acud7zvo.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> writes:

> Maybe that (the mostly bit) is what needs to be documented/specified
> i.e. any differences between the Linux user space ABI and those two
> standards.  Surely that difference is reasonably stable and having it
> documented in a single place would be useful.

Andries Brouwer's linux manpages did exactly that for many years.
Of course there are sometimes mistakes and bugs in them, but 
he accepts patches.

-Andi
