Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267034AbRGML1N>; Fri, 13 Jul 2001 07:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267036AbRGML1D>; Fri, 13 Jul 2001 07:27:03 -0400
Received: from weta.f00f.org ([203.167.249.89]:4739 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S267034AbRGML0y>;
	Fri, 13 Jul 2001 07:26:54 -0400
Date: Fri, 13 Jul 2001 23:26:50 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Craig Soules <soules@happyplace.pdl.cmu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
Message-ID: <20010713232650.D4814@weta.f00f.org>
In-Reply-To: <E15KnX2-0006qk-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15KnX2-0006qk-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2001 at 09:57:55PM +0100, Alan Cox wrote:

    NFS is most emphatically not a posix compliant FS, at the best of
    times.

Thats my point... why are we requiring file-systems and knfsd do all
sorts of psycho-acoustic-dildonics to make it look like one?  Why not
just accept its not very posix like and that good-enough, is, well,
good-enough?



  --cw
