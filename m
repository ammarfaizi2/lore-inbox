Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289050AbSAFXem>; Sun, 6 Jan 2002 18:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289045AbSAFXeb>; Sun, 6 Jan 2002 18:34:31 -0500
Received: from weta.f00f.org ([203.167.249.89]:42949 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S288932AbSAFXe1>;
	Sun, 6 Jan 2002 18:34:27 -0500
Date: Mon, 7 Jan 2002 12:37:26 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Gerrit Huizenga <gerrit@us.ibm.com>,
        "M. Edward Borasky" <znmeb@aracnet.com>,
        Harald Holzer <harald.holzer@eunet.at>, linux-kernel@vger.kernel.org
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
Message-ID: <20020106233726.GA26491@weta.f00f.org>
In-Reply-To: <20020106032030.A27926@redhat.com> <E16NFxv-0005e4-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16NFxv-0005e4-00@the-village.bc.nu>
User-Agent: Mutt/1.3.25i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Jan 06, 2002 at 04:16:07PM +0000, Alan Cox wrote:

    You don't neccessarily need PSE. Migrating to an option to support
    > 4K _virtual_ page size is more flexible for x86, although it
    would need glibc getpagesize() fixing I think, and might mean a
    few apps wouldnt run in that configuration.

If someone has a minute or so, can someone briefly explain the
difference(s) between PSE and PAE?



  --cw
