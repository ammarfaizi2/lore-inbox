Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317506AbSINUVY>; Sat, 14 Sep 2002 16:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317517AbSINUVY>; Sat, 14 Sep 2002 16:21:24 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:44022
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317506AbSINUVX>; Sat, 14 Sep 2002 16:21:23 -0400
Subject: Re: Problem with 2.4.19/2.4.20-pre7 multiple root floppy disks-
	2.4.18 works.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alan Miles <alanmiles@hfx.eastlink.ca>
Cc: linux-kernel@vger.kernel.org, Riley@Williams.Name
In-Reply-To: <JLEBIHHBMBHBAFPAJLEFOECFDAAA.alanmiles@hfx.eastlink.ca>
References: <JLEBIHHBMBHBAFPAJLEFOECFDAAA.alanmiles@hfx.eastlink.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 14 Sep 2002 21:27:55 +0100
Message-Id: <1032035275.13636.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-13 at 21:08, Alan Miles wrote:
> I reported this problem with 2.4.19 and have just tested the 2.4.20-pre7
> kernel. The same problem exists there.
> I must re-iterate that 2.4.18 works fine with all of my 7 uncompressed
> 1.44MB floppy disks, and the 2.4.18 system boots up fine.

Yes its in my bug list. Its up to someone it matters to to provide
patches. It could be a ramdisk change. it could well come from the
initrd loading cleanup/root ramfs stuff.

