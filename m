Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135691AbRDSUaT>; Thu, 19 Apr 2001 16:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135692AbRDSUaJ>; Thu, 19 Apr 2001 16:30:09 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:29889 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135691AbRDSU35>;
	Thu, 19 Apr 2001 16:29:57 -0400
Message-ID: <3ADF4AC0.2485C0BC@mandrakesoft.com>
Date: Thu, 19 Apr 2001 16:29:52 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tytso@valinux.com
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger@turbolinux.com>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] ext2 inode size (on-disk)
In-Reply-To: <20001202014045.F2272@parcelfarce.linux.theplanet.co.uk> <Pine.GSO.4.21.0104190719240.16930-100000@weyl.math.psu.edu> <20010419161003.E17837@snap.thunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tytso@valinux.com wrote:
> In the long run, it probably makes sense to adjust the algorithms to
> allow for non-power-of-two inode sizes,

If you don't mind, does that imply packing inodes across block
boundaries?

Regards,

	Jeff


-- 
Jeff Garzik       | "The universe is like a safe to which there is a
Building 1024     |  combination -- but the combination is locked up
MandrakeSoft      |  in the safe."    -- Peter DeVries
