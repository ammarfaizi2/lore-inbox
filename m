Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262232AbREXTtu>; Thu, 24 May 2001 15:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262238AbREXTtk>; Thu, 24 May 2001 15:49:40 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:59154 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S262232AbREXTte>; Thu, 24 May 2001 15:49:34 -0400
Date: Thu, 24 May 2001 21:46:41 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Hans Reiser <reiser@namesys.com>
Cc: Andi Kleen <ak@suse.de>, Andreas Dilger <adilger@turbolinux.com>,
        monkeyiq <monkeyiq@users.sourceforge.net>,
        linux-kernel@vger.kernel.org, Nikita Danilov <god@namesys.com>
Subject: Re: Dying disk and filesystem choice.
Message-ID: <20010524214641.E10968@arthur.ubicom.tudelft.nl>
In-Reply-To: <m3bsoj2zsw.fsf@kloof.cr.au> <200105240658.f4O6wEWq031945@webber.adilger.int> <20010524103145.A9521@gruyere.muc.suse.de> <3B0D3C99.255B5A24@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B0D3C99.255B5A24@namesys.com>; from reiser@namesys.com on Thu, May 24, 2001 at 09:53:45AM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2001 at 09:53:45AM -0700, Hans Reiser wrote:
> No, reiserfs does have badblock support!!!!
> 
> You just have to get it as a separate patch from us because it was
> written after code freeze.

IMHO we are not that deep into code freeze anymore. Freevxfs got added
in linux-2.4.5-pre*, so I think that a patch that adds a useful feature
like badblock support would be OK.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
