Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316089AbSE3Bix>; Wed, 29 May 2002 21:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316099AbSE3Biw>; Wed, 29 May 2002 21:38:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62386 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316089AbSE3Biu>;
	Wed, 29 May 2002 21:38:50 -0400
Date: Wed, 29 May 2002 18:23:24 -0700 (PDT)
Message-Id: <20020529.182324.44462071.davem@redhat.com>
To: marcelo@conectiva.com.br
Cc: lmb@suse.de, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: Linux 2.4.19-pre9
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0205292123520.9955-100000@freak.distro.conectiva>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Marcelo Tosatti <marcelo@conectiva.com.br>
   Date: Wed, 29 May 2002 21:34:23 -0300 (BRT)

   > > <davem@nuts.ninka.net> (02/05/06 1.383.11.22)
   > > 	soft-fp fix:

   David, Greg, and others, please, more readable changelogs :)
   
I don't understand what people want in that particular kind
of case.  I made software fp emulation fixes, four of them to
be precise.  And on the first line I describe in general what
I'm doing, which is soft-fp bug fixes :-)

I do the same thing for a batch of sparc64 fixes, the first
line always is the toplevel description:

sparc64 fixes:

which proceeds the actual details:

- Fix signal blah handling
- Don't bleh during ptrace
- Disable interrupts around foo
- Fix IP checksum calculations when bar

Now tell me what is more appropriate on the first line and
I'll consider it :-)
