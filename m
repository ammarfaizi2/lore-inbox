Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbTHZUqE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 16:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbTHZUqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 16:46:03 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:32680 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S262912AbTHZUqB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 16:46:01 -0400
Date: Tue, 26 Aug 2003 22:37:58 +0200
From: Dominik Brodowski <linux@brodo.de>
To: Bas Mevissen <ml@basmevissen.nl>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.xx and configuring PCMCIA cards without cardutils
Message-ID: <20030826203758.GB18392@brodo.de>
References: <3F4B777E.50807@basmevissen.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4B777E.50807@basmevissen.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 05:06:38PM +0200, Bas Mevissen wrote:
> Hi,
> 
> For a small computer, I want to use PCMCIA compiled into the kernel. I 
> only have 1 network card (fixed) in a PCMCIA slot. The kernel should 
> boot (from disk) with a NFS root. Because I want to keep things as small 
> as possible, I want to go without an initrd with cardutils.
> 
> So I'm wondering how to configure the network card from kernel space, if 
> possible at all.

Unfortunately, this is neither possible with 2.4. or 2.6. at the moment, but
there's work going on [for 2.6.+ only] which will eventually lead to such 
possibilities.

	Dominik
