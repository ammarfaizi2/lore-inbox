Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285506AbRLGUVb>; Fri, 7 Dec 2001 15:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285505AbRLGUVT>; Fri, 7 Dec 2001 15:21:19 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:54767 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S285506AbRLGUVA>; Fri, 7 Dec 2001 15:21:00 -0500
Date: Fri, 7 Dec 2001 20:20:36 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Nathan Scott <nathans@sgi.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Andi Kleen <ak@suse.de>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] Revised extended attributes interface
Message-ID: <20011207202036.J2274@redhat.com>
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com>; from nathans@sgi.com on Wed, Dec 05, 2001 at 02:32:10PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 05, 2001 at 02:32:10PM +1100, Nathan Scott wrote:
 
> Here is the revised interface.  I believe it takes into account
> the issues raised so far - further suggestions are also welcome,
> of course.

This is looking OK as far as EAs go.  However, there is still no
mention of ACLs specifically, except an oblique reference to
""system.posix_acl_access".  

Is there no consensus on this?  In previous proposals we've at least
tried to deal with it to some extent.

Cheers,
 Stephen
