Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTFISJL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 14:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbTFISJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 14:09:11 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:32690 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263062AbTFISJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 14:09:10 -0400
Date: Mon, 9 Jun 2003 20:22:49 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Coding standards.  (Was: Re: [PATCH] [2.5] Non-blocking write can block)
Message-ID: <20030609182249.GB13811@wohnheim.fh-wedel.de>
References: <Pine.HPX.4.33L.0306040144400.8930-100000@punch.eng.cam.ac.uk> <20030604065336.A7755@infradead.org> <3EDE0E85.7090601@techsource.com> <20030607001202.GB14475@kroah.com> <3EE4B4C3.80902@techsource.com> <20030609163959.GA13811@wohnheim.fh-wedel.de> <Pine.LNX.4.55.0306091001270.3614@bigblue.dev.mcafeelabs.com> <3EE4C4CD.1050809@inet.com> <Pine.LNX.4.53.0306091346150.226@chaos> <Pine.LNX.4.55.0306091101260.3614@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.55.0306091101260.3614@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 June 2003 11:07:32 -0700, Davide Libenzi wrote:
> 
> You know why the code you reported is *wrong* (besides from how
> techincally do things) ? Mixing lower and upper case, using long variable
> and function names, etc... are simply a matter of personal taste and you
> cannot say that such code is "absolutely" wrong. The code is damn wrong
> because it violates about 25 sections of the project's defined CodingStyle
> document, that's why it is wrong.

Call it as you may.  Whether some style violates more sections of the
CodingStyle than exist in written form or it hurts the taste of 99% of
all developers ever having to tough it, my short form for that is "bad
style".

Point remains, there is a lot of "bad style" and inconsistency in the
kernel.  But fixing all of it and keeping it fixed would result in a
lot of work and maybe a couple of device drivers less.  For what gain?

Jörn

-- 
Measure. Don't tune for speed until you've measured, and even then
don't unless one part of the code overwhelms the rest.
-- Rob Pike
