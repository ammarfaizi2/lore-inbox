Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265867AbSIRJhd>; Wed, 18 Sep 2002 05:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265869AbSIRJhc>; Wed, 18 Sep 2002 05:37:32 -0400
Received: from [195.39.17.254] ([195.39.17.254]:4224 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265867AbSIRJgp>;
	Wed, 18 Sep 2002 05:36:45 -0400
Date: Tue, 17 Sep 2002 16:07:23 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       "lse-tech@lists.sourceforge.net" <lse-tech@lists.sourceforge.net>
Subject: Re: 2.5.35-mm1
Message-ID: <20020917160722.G39@toy.ucw.cz>
References: <3D858515.ED128C76@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3D858515.ED128C76@digeo.com>; from akpm@digeo.com on Mon, Sep 16, 2002 at 12:15:33AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.35/2.5.35-mm1/
> 
> Significant rework of the new sleep/wakeup code - make it look totally
> different from the current APIs to avoid confusion, and to make it
> simpler to use.

Did you add any hooks to allow me to free memory for swsusp?
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

