Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267969AbUBRThH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 14:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267967AbUBRThH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 14:37:07 -0500
Received: from gprs156-45.eurotel.cz ([160.218.156.45]:20354 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267966AbUBRThD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 14:37:03 -0500
Date: Wed, 18 Feb 2004 20:36:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][1/6] A different KGDB stub
Message-ID: <20040218193624.GA408@elf.ucw.cz>
References: <20040217220249.GB16881@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040217220249.GB16881@smtp.west.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following is the core bits to this KGDB stub.

What are those weak functions good for? Can't we simply assume that
any architecture that allows CONFIG_KGDB provides neccessary
functions?
								Pavel
PS: Also.. how to proceed? Should I split your patches into "normal"
and "lite" parts and submit to Amit?

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
