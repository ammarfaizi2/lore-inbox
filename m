Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbUAaHXA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 02:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbUAaHXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 02:23:00 -0500
Received: from [64.218.206.163] ([64.218.206.163]:16806 "HELO
	arumekun.no-ip.com") by vger.kernel.org with SMTP id S263598AbUAaHW6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 02:22:58 -0500
From: Luke-Jr <luke7jr@yahoo.com>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Swsusp-devel] Software Suspend 2.0
Date: Sat, 31 Jan 2004 07:22:46 +0000
User-Agent: KMail/1.5.94
Cc: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1075436665.2086.3.camel@laptop-linux> <200401310622.17530.luke7jr@yahoo.com> <1075531042.18161.35.camel@laptop-linux>
In-Reply-To: <1075531042.18161.35.camel@laptop-linux>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200401310722.51472.luke7jr@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 31 January 2004 06:37 am, Nigel Cunningham wrote:
> On Sat, 2004-01-31 at 19:22, Luke-Jr wrote:
> > Except that it doesn't seem to work...
> > 1. patched in software-suspend-core-2.0-whole -- worked fine
> > 2. software-suspend-linux-2.6.1-rev3-whole:
> > 	2a. can't autodetect files to patch
> > 	2b. alot of patching fails
> Yes. Apply the patches the other way around - the version specific one
> first, then the core. Oh, you'll also want to get the latest 2.6.1 patch
> (http://swsusp.sf.net).
What is considered the latest? rev implies that it would be a revision over 
the normal 2.6.1 patch...
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD4DBQFAG1fKZl/BHdU+lYMRArrVAJ9Vtch17abyMnjidjrTqjR8P1ewZACY/pV4
sbplEZYAERvc5Ej2aDK/fg==
=VoOU
-----END PGP SIGNATURE-----
