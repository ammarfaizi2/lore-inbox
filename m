Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267901AbRGRQ0H>; Wed, 18 Jul 2001 12:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267904AbRGRQZ6>; Wed, 18 Jul 2001 12:25:58 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:22278 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S267901AbRGRQZx>; Wed, 18 Jul 2001 12:25:53 -0400
Date: Wed, 18 Jul 2001 18:22:01 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Steve Kieu <haiquy@yahoo.com>
Cc: Sam Thompson <samuelt@cervantes.dabney.caltech.edu>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <20010718182201.J13239@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010717211401.A322@caltech.edu> <20010718051859.44407.qmail@web10401.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010718051859.44407.qmail@web10401.mail.yahoo.com>; from haiquy@yahoo.com on Wed, Jul 18, 2001 at 03:18:59PM +1000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2001 at 03:18:59PM +1000, Steve Kieu wrote:
> My advice:
> 
> Dont use reiserfs,JFS
> it is ok to use ext2 
> 
> Go journalling? use ext3 or XFS
> 
> I have used  all of these fs and pick up this rule (up
> to now, not sure it remains right in the far  future)

FUD. I've been using reiserfs on quite some systems and never got any
problem. If reiserfs wouldn't be stable, SuSE wouldn't have supported
it as one of their stable filesystems for over a year.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
