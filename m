Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290858AbSBLJIS>; Tue, 12 Feb 2002 04:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290841AbSBLJIJ>; Tue, 12 Feb 2002 04:08:09 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:41737 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290845AbSBLJIC>;
	Tue, 12 Feb 2002 04:08:02 -0500
Date: Mon, 11 Feb 2002 21:31:27 +0100
From: Pavel Machek <pavel@suse.cz>
To: SA products <super.aorta@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: faking time
Message-ID: <20020211203127.GD1614@elf.ucw.cz>
In-Reply-To: <3C67AFD3.722C5471@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C67AFD3.722C5471@ntlworld.com>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I want to fake the time returned by the time() system call so that for a
> limited number
> of user space programs the time can be set to the future or the past
> without affecting
> other applications and without affecting system time-- Ideally I would
> like to install a
> loadable module to accomplish this- Any hints ? Any starting points?

You can do that in userland, see subterfugue.sf.net.
								Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
