Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030466AbWJYS5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030466AbWJYS5T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 14:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbWJYS5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 14:57:19 -0400
Received: from cantor.suse.de ([195.135.220.2]:11466 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030466AbWJYS5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 14:57:18 -0400
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Frustrated with Linux, Asus, and nVidia, and AMD
References: <453EEE46.9040600@perkel.com>
From: Andi Kleen <ak@suse.de>
Date: 25 Oct 2006 20:57:12 +0200
In-Reply-To: <453EEE46.9040600@perkel.com>
Message-ID: <p73vem8kyuv.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Perkel <marc@perkel.com> writes:

> Ok - I had a bad day today struggling with hardware. Having said that
> I'm somewhat frustrated with the lack of progress of Linux getting it
> right with Asus, nVidia, and AMD processors right.
> 
> I still have to run pci=nommconf to keep the server from locking
> up. That's with both 939 pin and AM2 motherboards.
> 
> This bug remains unresolved:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=6975
> 
> So what's up with the no progress?

The bug report only references ancient kernels (2.6.15, 2.6.17) How do you know there is no
progress?

-Andi
