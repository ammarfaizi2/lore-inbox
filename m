Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbTKJQf4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 11:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbTKJQfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 11:35:55 -0500
Received: from boefje.phys.uu.nl ([131.211.32.64]:57031 "EHLO
	boefje.phys.uu.nl") by vger.kernel.org with ESMTP id S263980AbTKJQfu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 11:35:50 -0500
Date: Mon, 10 Nov 2003 17:35:46 +0100
From: Peter Suetterlin <P.Suetterlin@astro.uu.nl>
To: linux-kernel@vger.kernel.org
Cc: lipeng@acm.org
Subject: Re: 512MB/1GB RAM 
Message-ID: <20031110163546.GA15096@hst33127.phys.uu.nl>
Reply-To: P.Suetterlin@astro.uu.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hello Peng,

I found your mail posting via google, because I do have the same
problems as you and was looking for a solution:

I have an Asus M3N that is supposed to support 1GB of memory.  I
bought it with 512MB, and everything worked fine,  Then I bought a
memory upgrade of another 512MB, and as soon as I plug it in, I get
two problems:

- without anything else, i.e., using the full 1GB of memory, the
  system is unusably slow (takes some 5-10 minutes just to boot).
  The main problem seems to be the hard disk, things that do not need
  the disk seem to work OK (I didn't try much - the system really is
  unusable...)

- I can restrict the memory usage with, e.g., mem=992M.  Then
  immediately the speed is back - but the pcmcia card slot no longer
  works. Same is true for the sound.

I'm (trying to) post this to the LKML - not sure if it's possible, as
I'm not subscribed.  But if soeone needs more info I'm willing to test
stuff out.
Best,

  Pit

-- 
Dr. Peter "Pit" Suetterlin                 http://www.astro.uu.nl/~suetter
Sterrenkundig Instituut Utrecht
Tel.: +31 (0)30 253 5225                   P.Suetterlin@astro.uu.nl
