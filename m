Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313355AbSDESXW>; Fri, 5 Apr 2002 13:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313380AbSDESXM>; Fri, 5 Apr 2002 13:23:12 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:12283
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313355AbSDESXF>; Fri, 5 Apr 2002 13:23:05 -0500
Date: Fri, 5 Apr 2002 10:25:04 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Sebastian Heidl <heidl@zib.de>, Pavel Machek <pavel@ucw.cz>,
        Keith Owens <kaos@ocs.com.au>, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.0 is available
Message-ID: <20020405182504.GN961@matchmail.com>
Mail-Followup-To: Sebastian Heidl <heidl@zib.de>,
	Pavel Machek <pavel@ucw.cz>, Keith Owens <kaos@ocs.com.au>,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <6529.1018004347@ocs3.intra.ocs.com.au> <20020405110913.GA11374@atrey.karlin.mff.cuni.cz> <20020405132324.L4640@csr-pc6.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 01:23:24PM +0200, Sebastian Heidl wrote:
> On Fri, Apr 05, 2002 at 01:09:14PM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > Nice, but what about decrypted version?
> It's signed. Just pipe it through gpg with Keiths public key.

Signed means that there is a checksum at the bottom that you can verify with
gpg/pgp to see if the message was tampered with, but the text itself it
still in ascii and not encoded.

This looks encrypted to me.

Mike
