Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267734AbTATA3g>; Sun, 19 Jan 2003 19:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267733AbTATA3g>; Sun, 19 Jan 2003 19:29:36 -0500
Received: from mail.webmaster.com ([216.152.64.131]:61684 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S267728AbTATA3f> convert rfc822-to-8bit; Sun, 19 Jan 2003 19:29:35 -0500
From: David Schwartz <davids@webmaster.com>
To: <adilger@clusterfs.com>
CC: Roman Zippel <zippel@linux-m68k.org>, Larry McVoy <lm@bitmover.com>,
       <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Sun, 19 Jan 2003 16:38:34 -0800
In-Reply-To: <20030119172004.K1594@schatzie.adilger.int>
Subject: Re: Is the BitKeeper network protocol documented?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20030120003836.AAA16474@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jan 2003 17:20:04 -0700, Andreas Dilger wrote:

>I think you are ignoring the fact that this clause (#3) in the GPL
>only
>relates only if "you copy or distribute the Program (or a work based
>on
>it, under Section 2) in object code or executable form".

	Here's the problem. RedHat ships the code in "object code or 
executable form". This requires them to distribute the source code in 
the "preferred form for modifications". The problem is, the preferred 
form for modifications might well be Linus' BK tree, which RedHat 
might not even have!

>Again you are ignoring the fact that there are other methods by 
>which
>the source code is available in the "preferred form", just not quite
>as
>timely as directly from the BK repository (which is itself in a
>form, SCCS,
>which does not require BK to access), and there is nothing in the
>GPL which
>requires that the source be made avaible instantly.

	If you assume that live access to Linus' BK tree is the preferred 
form for modifying the Linux kernel, then RedHat can't ship a 
compiled kernel if they can't give people access to Linus' 
repository.

	The GPL is nonsense. Lots of people have suffered absurdities 
similar to this one in a crazy attempt to comply with it. I think if 
the people who *chose* it had to suffer its insanities a little, 
they'd think twice the next time they choose a license for their open 
source projects.

	DS


