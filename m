Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263422AbTDXAPv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 20:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264326AbTDXAPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 20:15:51 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:19637 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S263422AbTDXAPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 20:15:50 -0400
Date: Thu, 24 Apr 2003 02:23:57 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Marc Giger <gigerstyle@gmx.ch>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030424002357.GB2925@elf.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A847E96E0E@orsmsx401.jf.intel.com> <20030424000344.GC32577@atrey.karlin.mff.cuni.cz> <1051142550.4306.10.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051142550.4306.10.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I don't believer I've ever seen things get OOM killed. Instead, page
> cache is discarded until things do fit.

In extreme cases, things just may not fit. It does not happen too
often in real life.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
