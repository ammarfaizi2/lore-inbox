Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132381AbRCZHov>; Mon, 26 Mar 2001 02:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132382AbRCZHoc>; Mon, 26 Mar 2001 02:44:32 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:56296 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132381AbRCZHoX>;
	Mon, 26 Mar 2001 02:44:23 -0500
Message-ID: <3ABEF32E.B8142334@mandrakesoft.com>
Date: Mon, 26 Mar 2001 02:43:42 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
Cc: esr@thyrsus.com, "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: CML1 cleanup patch
In-Reply-To: <23860.985591724@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> That just leaves the 17 names of the form CONFIG_[0-9]*.  Only the 8139
> is likely to affect outside the kernel and the argument that renaming
> config options might affect external packages does not hold.  The
> recent aic7xxx change broke pcmcia on 2.2 kernels but we can work round
> it.

There is no good reason to restrict the CML2 identifier namespace.

This is a policy change not a cleanup.

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
