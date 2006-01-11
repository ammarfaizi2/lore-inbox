Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWAKKCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWAKKCQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 05:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWAKKCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 05:02:16 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40896 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751435AbWAKKCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 05:02:15 -0500
Date: Wed, 11 Jan 2006 11:02:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Mattia Dongili <malattia@linux.it>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, linux-acpi@vger.kernel.org
Subject: Re: 2.6.15-mm2: reiser3 oops on suspend and more (bonus oops shot!)
Message-ID: <20060111100204.GD2574@elf.ucw.cz>
References: <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110170037.4a614245.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > [1]: http://oioio.altervista.org/linux/dsc03133.jpg

Looking at the picture... I'd try again without preempt. Any taints?
Is machine rock solid otherwise?
								Pavel

-- 
Thanks, Sharp!
