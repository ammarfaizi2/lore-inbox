Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261365AbSJ1QtG>; Mon, 28 Oct 2002 11:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261366AbSJ1QtG>; Mon, 28 Oct 2002 11:49:06 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:5137 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S261365AbSJ1QtE>;
	Mon, 28 Oct 2002 11:49:04 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15805.27643.403378.829985@laputa.namesys.com>
Date: Mon, 28 Oct 2002 19:55:23 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: landley@trommello.org
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: 2.5 merge candidate list, final version.  (End of "crunch time" series.)
In-Reply-To: <200210280534.16821.landley@trommello.org>
References: <200210280534.16821.landley@trommello.org>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Windows: the joke that kills.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley writes:
 > Hi Linus.
 > 
 > This list is the result of a week of scouring linux-kernel and posting
 > more or less daily versions soliciting feedback from everybody seriously
 > trying to get a patch into 2.5.  This is the ninth and final posting of
 > this list.
 > 
 > Previous versions, and the discussion they spawned, were here:
 > 1.0) http://lists.insecure.org/lists/linux-kernel/2002/Oct/7006.html
 > 1.1) http://lists.insecure.org/lists/linux-kernel/2002/Oct/7051.html
 > 1.2) http://lists.insecure.org/lists/linux-kernel/2002/Oct/7363.html
 > 1.3) http://lists.insecure.org/lists/linux-kernel/2002/Oct/7452.html
 > 1.4) http://lists.insecure.org/lists/linux-kernel/2002/Oct/7827.html
 > 1.5) http://lists.insecure.org/lists/linux-kernel/2002/Oct/8174.html

[...]

 > http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Hotcpu/hotcpu-cpudown.patch.gz
 > 
 > ----------------------------------------------------------------------------
 > 
 > 30) Reiser4.
 > 
 > I don't have a patch yet, but Hans Reiser is very insistent that this
 > will be ready by halloween.  (VERY insistent.)  I'll let him speak for
 > himself:
 > http://lists.insecure.org/lists/linux-kernel/2002/Oct/8793.html
 > 
 > And again (promises, promises):
 > http://lists.insecure.org/lists/linux-kernel/2002/Oct/9082.html
 > 
 > Still no patch at the time of this writing, though.  In theory it
 > should show up here:
 > http://namesys.com/download.html

Snapshot is available at http://www.namesys.com/snapshots/:

reiser4 proper:
http://www.namesys.com/snapshots/reiser4-2002.10.24.tar.gz

necessary changes to the core kernel, plus some UML patches, plus some
patches for debugging:
http://www.namesys.com/snapshots/reiser4-core-2002.10.24.diff

utils:
http://www.namesys.com/snapshots/reiser4progs-2002.10.24.tar.gz

I shall produce newer snapshot to-morrow.

It does work, but code is not production quality yet. Do *NOT* put
anything close to critical data on it.

 > 
 > Or perhaps here:
 > ftp://ftp.lugoj.org/pub/reiserfs/devlinux.com/pub/namesys/reiserfs-for-2.5
 > 
 > In the meantime, all I can find on Reiser4 is some kind of hybrid
 > marketing brochure/design document thing:
 > http://www.reiserfs.org/v4/v4.html
 > 
 > Did I mention Hans was insistent?  The man can make puppy eyes through email.
 > It's quite impressive.

Works without email too. :-)

 > -- 
 > http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
 > CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?

Nikita.

 > -
