Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSEHHoc>; Wed, 8 May 2002 03:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311752AbSEHHob>; Wed, 8 May 2002 03:44:31 -0400
Received: from 213-98-127-214.uc.nombres.ttd.es ([213.98.127.214]:36265 "HELO
	demo.mitica") by vger.kernel.org with SMTP id <S311749AbSEHHoa>;
	Wed, 8 May 2002 03:44:30 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <Pine.LNX.4.44.0205070944020.2509-100000@home.transmeta.com>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 08 May 2002 09:48:50 +0200
Message-ID: <m2r8knkrkt.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "linus" == Linus Torvalds <torvalds@transmeta.com> writes:

Hi

linus> (Side note: I'm afraid that don't think backwards compatibility weighs
linus> very heavily on an embedded setup - I'm more thinking about things like "a
linus> regular RedHat/SuSE/Debian/whatever install won't work any more".)

here at Mandrake we have a patch for the install kernel to remove the
/proc/ide, and  I think that we got it from redhat, that means that at
least two distros preffer to save ~25kb in the boot kernels than the
reporting that they do :p

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
