Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286750AbSBCJPo>; Sun, 3 Feb 2002 04:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286712AbSBCJPf>; Sun, 3 Feb 2002 04:15:35 -0500
Received: from tapu.f00f.org ([63.108.153.39]:56253 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S286647AbSBCJPT>;
	Sun, 3 Feb 2002 04:15:19 -0500
Date: Sun, 3 Feb 2002 01:13:54 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "David S. Miller" <davem@redhat.com>, vandrove@vc.cvut.cz,
        torvalds@transmeta.com, garzik@havoc.gtf.org,
        linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
Message-ID: <20020203091345.GA11207@tapu.f00f.org>
In-Reply-To: <E16WQYs-0003Ux-00@the-village.bc.nu> <m17kpv8amu.fsf@frodo.biederman.org> <20020203080134.C19813@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020203080134.C19813@dea.linux-mips.net>
User-Agent: Mutt/1.3.27i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03, 2002 at 08:01:35AM +0100, Ralf Baechle wrote:

    Is it really worth the effort?  During the past year the average
    size of embedded systems that people want to use for seems to have
    increased dramatically.  In case of the MIPS port the core
    activity is about to move away from the 32-bit to 64-bit kernel.

For some hand-held devices (eg. iPAQ), we want as much memory free as
possible as the only filesystem available is ramfs... moving to 64-bit
would be unthinkable! :)


  --cw

