Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272262AbRH3PIx>; Thu, 30 Aug 2001 11:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272260AbRH3PIo>; Thu, 30 Aug 2001 11:08:44 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:64273 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S272258AbRH3PIa>;
	Thu, 30 Aug 2001 11:08:30 -0400
Date: Thu, 30 Aug 2001 17:08:46 +0200
From: Yves Rougy <yves.rougy@fr.alcove.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: YAFB: Yet Another Filesystem Bench
Message-ID: <20010830170846.A30844@ontario.alcove-fr>
Reply-To: yrougy@rougy.net
In-Reply-To: <3B8A6122.3C784F2D@us.ibm.com> <3B8A9070.AD43D0E7@osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3B8A9070.AD43D0E7@osdlab.org>
User-Agent: Mutt/1.3.20i
X-Arbitrary-Number-Of-The-Day: 42
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am also doing such comparisons, with IOZone and Bonnie++
The currents results are available at 
http://www.pingouin.org/linux/fsbench/

More results are to come, especially to see the notail option impact of
Reiserfs with iozone and bonnie++.

Of course, comments are welcome...

	Regards,
		Yves

Randy.Dunlap(rddunlap@osdlab.org)@Mon, Aug 27, 2001 at 11:24:48AM -0700:
> Hi,
> 
> I am doing some similar FS comparisons, but using IOzone
> (www.iozone.org)
> instead of Netbench.
> 
> Some preliminary (mostly raw) data are available at:
> http://www.osdlab.org/reports/journal_fs/
> (updated today).
[...]
> Andrew Theurer wrote:
> > 
> > Hello all,
> > 
> > I recently starting doing some fs performance comparisons with Netbench
> > and the journal filesystems available in 2.4:  Reiserfs, JFS, XFS, and
> > Ext3.  I thought some of you may be interested in the results.  Below
> > is the README from the http://lse.sourceforge.net.  There is a kernprof
> > for each test, and I am working on the lockmeter stuff right now.  Let
> > me know if you have any comments.
> > 
> > Andrew Theurer
> > IBM LTC
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Yves ROUGY - Yves.Rougy@fr.alcove.com
Coordinateur du Laboratoire - Lab Manager
Ingénieur Logiciels Libres - Open Source Software Engineer

Alcôve "L'informatique est libre" http://www.alcove.com
