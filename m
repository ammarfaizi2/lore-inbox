Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289762AbSBJVaF>; Sun, 10 Feb 2002 16:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289761AbSBJV3z>; Sun, 10 Feb 2002 16:29:55 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:56329 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S289767AbSBJV3v>;
	Sun, 10 Feb 2002 16:29:51 -0500
Date: Sun, 10 Feb 2002 22:05:38 +0100
From: Pavel Machek <pavel@suse.cz>
To: Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread abstraction, take two
Message-ID: <20020210210536.GB239@elf.ucw.cz>
In-Reply-To: <20020209180305.A11717@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020209180305.A11717@caldera.de>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is a new version of the ktread abstraction which incorporates
> suggestions by Andi Kleen, Jeff Garzik and Andrew Morton.

Could you convert some kernel thread to the new interface to show how
it simplifies things?
								Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
