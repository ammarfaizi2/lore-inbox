Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266364AbUG0IxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266364AbUG0IxO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 04:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266370AbUG0IxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 04:53:13 -0400
Received: from waste.org ([209.173.204.2]:61057 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266364AbUG0IxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 04:53:12 -0400
Date: Tue, 27 Jul 2004 03:53:09 -0500
From: Matt Mackall <mpm@selenic.com>
To: Junio C Hamano <junkio@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
Message-ID: <20040727085309.GB18675@waste.org>
References: <20040726200126.GQ5414@waste.org> <7v4qntc06o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7v4qntc06o.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2004 at 01:40:47AM -0700, Junio C Hamano wrote:
> >>>>> "MM" == Matt Mackall <mpm@selenic.com> writes:
> 
> MM> Here's a scenario: corrupt government agency secretly watermarks
> MM> incriminating documents. Brave whistleblower puts them on his laptop's
> MM> cryptoloop fs, but gets taken aside by customs agents on his way out
> MM> of the country. Agents check his disk for evidence of the watermark
> MM> and find enough evidence...
> 
> Jari's exploit uses the property that his watermarks are
> encrypted to identical ciphertext blocks, but does it mean that
> the technique can be used to prove that identical ciphertext are
> from the watermarks and not coming from mere coincidence?

Probably. Or maybe just enough evidence to pull out the electrodes or
equivalent.

-- 
Mathematics is the supreme nostalgia of our time.
