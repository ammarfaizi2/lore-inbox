Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284612AbRLFFsW>; Thu, 6 Dec 2001 00:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284806AbRLFFsM>; Thu, 6 Dec 2001 00:48:12 -0500
Received: from zok.sgi.com ([204.94.215.101]:10626 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S284439AbRLFFrz>;
	Thu, 6 Dec 2001 00:47:55 -0500
Date: Thu, 6 Dec 2001 16:46:25 +1100
From: Nathan Scott <nathans@sgi.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Andi Kleen <ak@suse.de>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [PATCH] Revised extended attributes interface
Message-ID: <20011206164625.G50483@wobbly.melbourne.sgi.com>
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <5.1.0.14.2.20011205090142.04ab5b20@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.2.20011205090142.04ab5b20@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Wed, Dec 05, 2001 at 09:08:12AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 09:08:12AM +0000, Anton Altaparmakov wrote:
> Looks good to me. Just one tiny point: you seem to like setting error=xyz; 
> a lot which is completely unnecessary some times. Any particular reason? 

No compelling reason - I've switched to your version, new patch is here:
http://oss.sgi.com/cgi-bin/cvsweb.cgi/linux-2.4-xfs/cmd/xfsmisc/xattr.patch

cheers.

-- 
Nathan
