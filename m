Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262295AbSJODIQ>; Mon, 14 Oct 2002 23:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262297AbSJODIQ>; Mon, 14 Oct 2002 23:08:16 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:56723 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S262295AbSJODIP>; Mon, 14 Oct 2002 23:08:15 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Christoph Hellwig <hch@sgi.com>
Date: Tue, 15 Oct 2002 13:14:03 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15787.34811.125941.874118@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] switch knfsd to vfs_read/vfs_write
In-Reply-To: message from Christoph Hellwig on Tuesday October 15
References: <20021015002110.A18265@sgi.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday October 15, hch@sgi.com wrote:
> Switch knfsd to vfs_read/vfs_write to work on aio-only filesystems.
> This also gets stuff like the LSM checks and mandatory lock checking
> for free.
> 

Thanks.  I'll pass it on.

NeilBrown
