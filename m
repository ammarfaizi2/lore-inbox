Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284866AbRLFADs>; Wed, 5 Dec 2001 19:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284870AbRLFADj>; Wed, 5 Dec 2001 19:03:39 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:23284 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S284866AbRLFADb>; Wed, 5 Dec 2001 19:03:31 -0500
Date: Wed, 5 Dec 2001 15:55:09 -0800
From: Chris Wright <chris@wirex.com>
To: "Garst R. Reese" <reese@isn.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17-pre4 extra-version
Message-ID: <20011205155509.B9588@figure1.int.wirex.com>
Mail-Followup-To: "Garst R. Reese" <reese@isn.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C0EB178.4A599A31@isn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C0EB178.4A599A31@isn.net>; from reese@isn.net on Wed, Dec 05, 2001 at 07:44:56PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Garst R. Reese (reese@isn.net) wrote:
> It really does help to keep extra version uptodate ;)

seem fine to me...

<from patch-2.4.17-pre4.bz2>

diff --exclude=CVS -Nur linux-2.4.16/Makefile linux/Makefile
--- linux-2.4.16/Makefile       Mon Nov 26 08:35:11 2001
+++ linux/Makefile      Wed Dec  5 16:49:45 2001
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
-SUBLEVEL = 16
-EXTRAVERSION =
+SUBLEVEL = 17
+EXTRAVERSION = -pre4

cheers,
-chris
