Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316480AbSEOUGR>; Wed, 15 May 2002 16:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316481AbSEOUGQ>; Wed, 15 May 2002 16:06:16 -0400
Received: from [195.39.17.254] ([195.39.17.254]:27543 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316480AbSEOUGP>;
	Wed, 15 May 2002 16:06:15 -0400
Date: Wed, 15 May 2002 21:48:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Elladan <elladan@eskimo.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
Message-ID: <20020515194857.GA6485@elf.ucw.cz>
In-Reply-To: <elladan@eskimo.com> <200205131709.g4DH9Fjv006328@pincoya.inf.utfsm.cl> <20020513105250.A30395@eskimo.com> <20020513185723.A2657@infradead.org> <20020514092254.A2581@eskimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I went to google and attempted to find information about the root
> reserve space for ext2, as a user wondering about the feature would.  I
> couldn't find any documentation that states it's purely a fragmentation
> and convenience feature.  I did, however, find documents stating
> otherwise.  Note how even Documentation/filesystems/ext2.txt states that
> it's a security feature?
> 
> If this is not a security feature, Documentation/filesystems/ext2.txt
> needs to be changed.  Eg., 

I'd suggest you to mail to bugtraq@securityfocus.com; it sounds like
security hole to me, and probably common across many unix variants.

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
