Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132267AbRBDVQo>; Sun, 4 Feb 2001 16:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132275AbRBDVQf>; Sun, 4 Feb 2001 16:16:35 -0500
Received: from foozle.turbogeek.org ([216.233.172.106]:16132 "EHLO
	foozle.turbogeek.org") by vger.kernel.org with ESMTP
	id <S132267AbRBDVQ0>; Sun, 4 Feb 2001 16:16:26 -0500
Date: Sun, 4 Feb 2001 15:16:54 -0600
From: "Jeremy M. Dolan" <jmd@turbogeek.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: Re: Configure.help typo fix
Message-ID: <20010204151654.A332@foozle.turbogeek.org>
In-Reply-To: <20010205021325.755D.RAMSY@linux.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010205021325.755D.RAMSY@linux.or.jp>; from ramsy@linux.or.jp on Mon, Feb 05, 2001 at 02:22:11AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Feb 2001 02:22:11 +0000, Keitaro Yosimura wrote:
> Hi. Axel Boldt, Alan Cox, Linus Torvalds.

This might be a good time to mention Axel has passed maintainership of
Configure.help to myself. I'm currently working to combine Axel's fork
against Linux 2.4.1's Configure.help, which is requiring hand merging
a 260 kbyte diff, so it may be a week or two off.

Anyway, I thought it might be a good idea to update the MAINTAINERS
file to cut the flow of patches to Axel.

/jmd

--- linux-2.4.1/MAINTAINERS     Thu Feb  1 22:56:14 2001
+++ jmd-241/MAINTAINERS Sun Feb  4 14:43:05 2001
@@ -273,8 +273,8 @@
 S:     Maintained
 
 CONFIGURE.HELP
-P:     Axel Boldt
-M:     axel@uni-paderborn.de
+P:     Jeremy M. Dolan
+M:     jmd@turbogeek.org
 S:     Maintained
 
 COSA/SRP SYNC SERIAL DRIVER
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
