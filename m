Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262641AbSKCVlq>; Sun, 3 Nov 2002 16:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262357AbSKCVlq>; Sun, 3 Nov 2002 16:41:46 -0500
Received: from vsmtp4.tin.it ([212.216.176.224]:59850 "EHLO smtp4.cp.tin.it")
	by vger.kernel.org with ESMTP id <S262641AbSKCVlp>;
	Sun, 3 Nov 2002 16:41:45 -0500
Message-ID: <3DB5E74F004225E0@smtp4.cp.tin.it> (added by postmaster@virgilio.it)
Content-Type: text/plain; charset=US-ASCII
From: Flavio Stanchina <flavio.stanchina@tin.it>
Organization: not at all
To: Nicholas Wourms <nwourms@netscape.net>
Subject: Re: Petition against kernel configuration options madness...
Date: Sun, 3 Nov 2002 22:48:12 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200211031809.45079.josh@stack.nl> <3DB5E7CA00439C7E@smtp2.cp.tin.it> <3DC593A8.2030204@netscape.net>
In-Reply-To: <3DC593A8.2030204@netscape.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 November 2002 22:22, Nicholas Wourms wrote:

> This is true, but if you are going to make a report, make a
> report, don't advocate changing something which works for
> most as it stands.  From the subject, [...]

I agree, the subject is misleading.

> [...] The real issue here is that you really
> should *not* be copying 2.4 .config's over to a 2.5 tree.

Why souldn't I be able to do that? I was hoping that options missing from 
the loaded config would be set to the default value, which in the case of 
standard AT keyboard and PS/2 mouse is "yes, of course I want that".

> That way you'll be forced to go through all the options and
> get the proper "default" options for your platform enabled
> automatically.

How long will it take to go through all the options, your old config file 
at hand, and check that everything you need is there? How easy would it be 
to make a mistake?

-- 
Ciao,
    Flavio Stanchina
    Trento - Italy

Information is not knowledge. Knowledge is not wisdom.
Wisdom is not truth. Truth is not beauty. Beauty is not love.
Love is not music. Music is the best.
-- Frank Zappa
