Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312453AbSC3LDU>; Sat, 30 Mar 2002 06:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312449AbSC3LDL>; Sat, 30 Mar 2002 06:03:11 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:51648 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S312444AbSC3LDB>; Sat, 30 Mar 2002 06:03:01 -0500
Subject: Re: Re[2]: ANN: NTFS 2.0.1 for kernel 2.5.7 released
From: Nicholas Miell <nmiell@attbi.com>
To: Joachim Breuer <jmbreuer@gmx.net>
Cc: Nerijus Baliunas <nerijus@users.sourceforge.net>,
        Anton Altaparmakov <aia21@cus.cam.ac.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
	<linux-ntfs-dev@lists.sourceforge.net>,
        Padraig Brady <padraig@antefacto.com>
In-Reply-To: <m3vgbetkc8.fsf@venus.fo.et.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 30 Mar 2002 03:02:54 -0800
Message-Id: <1017486175.1713.2.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-03-30 at 02:34, Joachim Breuer wrote:
> What I would like to see (probably exists somewhere) is a (userland)
> tool which can fire up an exec image residing in a readable (not
> executable) file - that would take care of the "star office
> installation" case, as well. If said tool was called "run" it would
> have all semantics intuitively expected by me.
> 

You already have the program. It's called /lib/ld-linux.so.2

