Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137171AbREKQsB>; Fri, 11 May 2001 12:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137172AbREKQrw>; Fri, 11 May 2001 12:47:52 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:1030 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S137171AbREKQri>; Fri, 11 May 2001 12:47:38 -0400
Date: Fri, 11 May 2001 18:47:08 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Collectively Unconscious <swarm@warpcore.provalue.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 Crash Help, please
Message-ID: <20010511184707.J27167@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010511135829Z137139-406+427@vger.kernel.org> <Pine.LNX.4.10.10105110726410.15179-100000@warpcore.provalue.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10105110726410.15179-100000@warpcore.provalue.net>; from swarm@warpcore.provalue.net on Fri, May 11, 2001 at 07:32:41AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 07:32:41AM -0500, Collectively Unconscious wrote:
> I had an NFS server crash in an unfamiliar way.
> 
> 2.2.19 smp 2xPIII 450 
> 
> The screen was filled with varitions of [<8010997c>] and at the bottom of
> the screen was the following:
> 
> Code: 8b 4a 04 85 c9 74 22 8b 5a 18 8b 02 89 01 8b 0a 85 c9 74 08
> 
> Can anyone clue me in on this?

You have to decode the Oops to make it useful. See the files
REPORTING-BUGS and Documentation/oops-tracing.txt in the kernel source
tree.


Erik

PS: Instead of *replying* to an existing thread, you'd better *start* a
    new thread ("compose" instead of "reply"). If I killed the "write
    to dvd ram" thread I wouldn't have seen your message at all.

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
