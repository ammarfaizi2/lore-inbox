Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265124AbUFGXNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265124AbUFGXNW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 19:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbUFGXNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 19:13:22 -0400
Received: from cantor.suse.de ([195.135.220.2]:42210 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265124AbUFGXNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 19:13:21 -0400
To: Hal Nine <hal9@cyberspace.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Flushing the swap
References: <200406072234.SAA07853@grex.cyberspace.org>
From: Andreas Schwab <schwab@suse.de>
X-Yow: MERYL STREEP is my obstetrician!
Date: Tue, 08 Jun 2004 01:13:20 +0200
In-Reply-To: <200406072234.SAA07853@grex.cyberspace.org> (Hal Nine's message
 of "Mon, 7 Jun 2004 18:34:59 -0400")
Message-ID: <je3c572c8f.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hal Nine <hal9@cyberspace.org> writes:

> Is there any way of making linux flush out all pages out of swap
> space?  I want to have 0K of used swap space.

# swapoff -a

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
