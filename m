Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290461AbSBFMKT>; Wed, 6 Feb 2002 07:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290470AbSBFMKJ>; Wed, 6 Feb 2002 07:10:09 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:29452 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290454AbSBFMJv>;
	Wed, 6 Feb 2002 07:09:51 -0500
Date: Tue, 5 Feb 2002 22:29:25 +0100
From: Pavel Machek <pavel@suse.cz>
To: Britt Park <britt@drscience.sciencething.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UVFS Version 0.3
Message-ID: <20020205212925.GA14174@elf.ucw.cz>
In-Reply-To: <B87FFD42.48EF%britt@sciencething.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B87FFD42.48EF%britt@sciencething.org>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Version 0.3 of UVFS can be found at
> http://www.sciencething.org/geekthings/index.html
> 
> UVFS is a userspace filesystem kit.  This release fixes some small bugs
> found in recent testing and offers a multithreaded example
> filesystem.

Does it handle memory-full-of-writebackdata-and-userspace-swapped-out
deadlock?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
