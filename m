Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292879AbSCFBW6>; Tue, 5 Mar 2002 20:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292901AbSCFBWy>; Tue, 5 Mar 2002 20:22:54 -0500
Received: from ns.suse.de ([213.95.15.193]:30219 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292879AbSCFBWk>;
	Tue, 5 Mar 2002 20:22:40 -0500
Date: Wed, 6 Mar 2002 02:22:24 +0100
From: Dave Jones <davej@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Michael Bernstein <bernstein.46@osu.edu>,
        Mike Fedyk <mfedyk@matchmail.com>, Colin Walters <walters@debian.org>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org, opensource@cis.ohio-state.edu
Subject: Re: [opensource] Re: Petition Against Official Endorsement of BitKeeper by Linux Maintainers
Message-ID: <20020306022224.B6531@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alexander Viro <viro@math.psu.edu>,
	Michael Bernstein <bernstein.46@osu.edu>,
	Mike Fedyk <mfedyk@matchmail.com>,
	Colin Walters <walters@debian.org>,
	"Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
	linux-kernel@vger.kernel.org, opensource@cis.ohio-state.edu
In-Reply-To: <002f01c1c49e$874c3580$1900a8c0@sirius> <Pine.GSO.4.21.0203051946340.18755-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0203051946340.18755-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Tue, Mar 05, 2002 at 08:05:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 08:05:05PM -0500, Alexander Viro wrote:

 > BTW, bitkeeper doesn't solve the problems I have.  Ditto for CVS.  So I use
 > neither.  FWIW, BK is closer to what I need.  If it will ever get the things
 > I need right - I'll use it and damned if I'll hide that.

 Preach on brother Viro.  Faced with the mammoth task of somehow
 syncing a 6MB diff with Linus, I decided it was time to devote
 an afternoon (which then turned into an evening) to seeing if
 bk can make this easier.

 There's nothing in bk that makes my life any more difficult, and
 potential for it to make it a *lot* easier. And Larry seems
 open to suggestions, dispelling the "its closed commercial blah" myth.

 Splitting bits up could become even easier soon if Larry and I figure
 out a way to implement some of my perverse ideas for bending csets
 into something more flexable than what they currently are.

 Syncing from Linus to my tree isn't difficult, its the splitting bits
 up to push his way that takes time. bk is halfway towards almost
 automating this for me.  CVS and friends don't even get to the
 start line here.

 Hours of diff/grepdiff/filterdiff/vim, vs a few clicky clicky bits
 in bk citool.

 If you don't like the license, fine. Don't use it, but at least
 give everyone else the option of making up their own mind before
 you try to force _your_ opinion on others.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
