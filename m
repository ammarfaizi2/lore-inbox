Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261946AbREMXSH>; Sun, 13 May 2001 19:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261949AbREMXR5>; Sun, 13 May 2001 19:17:57 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:2825 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S261946AbREMXRo>; Sun, 13 May 2001 19:17:44 -0400
Date: Mon, 14 May 2001 11:17:39 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>,
        "David S. Miller" <davem@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>, Mauelshagen@sistina.com,
        linux-kernel@vger.kernel.org, mge@sistina.com, hch@caldera.de
Subject: Re: LVM 1.0 release decision
Message-ID: <20010514111739.A11330@metastasis.f00f.org>
In-Reply-To: <23605.989775371@redhat.com> <E14z0mG-0006og-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14z0mG-0006og-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, May 13, 2001 at 07:39:36PM +0100
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 07:39:36PM +0100, Alan Cox wrote:

    Or the 32bit libc shipped with the 64bit box. Lets face it, there
    is no reason you can't have a 32bit glibc 2.2 built to use 64bit
    calling conventions..

It doesn't work with binary compatability form other sources (e.g.
trying to run SunOS binaries under ultralinux and such like (I assume
this is possible?)). Then again, should SunOS binaries really be
making such ioctls?



  --cw
