Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289081AbSBISFX>; Sat, 9 Feb 2002 13:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289062AbSBISFM>; Sat, 9 Feb 2002 13:05:12 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:64780 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S283003AbSBISFD>;
	Sat, 9 Feb 2002 13:05:03 -0500
Date: Sat, 9 Feb 2002 19:00:58 +0100
From: Pavel Machek <pavel@suse.cz>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH: NEW ARCHITECTURE FOR 2.5.3] support for NCR voyager
Message-ID: <20020209180057.GB113@elf.ucw.cz>
In-Reply-To: <200202081825.g18IPSf03107@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202081825.g18IPSf03107@localhost.localdomain>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is essentially the same as the 2.5.2 patch except that it adds support 
> for the new migration cross processor interrupt.
> 
> As far as the new scheduler goes, the process affinity properties are much 
> better for the voyager, which is configured to have a fairly huge L3 cache 
> shared by several CPUs.  (My current voyager has 2 CPU cards with 4 pentium 
> CPUs each and 32Mb of L3 cache on each card).

Maybe you should stop calling it new architecture? Its mostly
i386-compatible, right?

BTW are those "current" machines, or is their production already
stopped?
									Pavel

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
