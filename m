Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262342AbREUUWQ>; Mon, 21 May 2001 16:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262269AbREUUWG>; Mon, 21 May 2001 16:22:06 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:43012 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S262215AbREUUV7>; Mon, 21 May 2001 16:21:59 -0400
Date: Mon, 21 May 2001 22:21:29 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: szonyi calin <caszonyi@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG ? and questions
Message-ID: <20010521222129.E7958@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010520150945.66552.qmail@web13907.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010520150945.66552.qmail@web13907.mail.yahoo.com>; from caszonyi@yahoo.com on Sun, May 20, 2001 at 08:09:45AM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2001 at 08:09:45AM -0700, szonyi calin wrote:
> I have a Cx 486/66 with 12 Megs of ram AST computer
> gcc 2.95.3, glibc 2.1.3, make 3.79.1 binutils 2.11 ??
> Problems:
> 1. When I try to run multiple (2) compilations on a
> 2.4.4 kernel usually one
> of them dies -- if it's gcc - signal 11 ,  if it's sh
> or rarely  make -
> segmentation fault.
> 
> It is not a hardware problem (with kernel 2.2.x it
> does not do this
> and I have a cooler on my cpu)

Are your sure? Check out the SIG11 FAQ at
http://www.bitwizard.nl/sig11/ .


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
