Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130209AbRBZPlv>; Mon, 26 Feb 2001 10:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130237AbRBZPll>; Mon, 26 Feb 2001 10:41:41 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:46854 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S130209AbRBZPl0>; Mon, 26 Feb 2001 10:41:26 -0500
Date: Mon, 26 Feb 2001 16:37:49 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Chris Mason <mason@suse.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Nick Pasich <npasich@crash.cts.com>, reiserfs-list@namesys.com
Subject: Re: [PATCH] Re: reiserfs: still problems with tail conversion
Message-ID: <20010226163749.D12809@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010225183201.D866@arthur.ubicom.tudelft.nl> <1136530000.983155244@tiny> <20010226120704.A12809@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010226120704.A12809@arthur.ubicom.tudelft.nl>; from J.A.K.Mouw@ITS.TUDelft.NL on Mon, Feb 26, 2001 at 12:07:04PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2001 at 12:07:04PM +0100, Erik Mouw wrote:
> On Sun, Feb 25, 2001 at 09:40:44PM -0500, Chris Mason wrote:
> > Any testing on non-production machines would be appreciated,
> > I'll forward to Linus/Alan once I've gotten more feedback.
> 
> Yes, this did the trick, I can't repeat it anymore after a first run.
> I'll let my code run for a couple of times to stress the system, but at
> first glance the bug seems to be fixed.

It has been running for quite some time in the background, and I can't
reproduce the bug.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
