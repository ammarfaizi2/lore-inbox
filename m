Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267527AbRGMVBt>; Fri, 13 Jul 2001 17:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267541AbRGMVBj>; Fri, 13 Jul 2001 17:01:39 -0400
Received: from weta.f00f.org ([203.167.249.89]:12675 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S267537AbRGMVBa>;
	Fri, 13 Jul 2001 17:01:30 -0400
Date: Sat, 14 Jul 2001 09:01:30 +1200
From: Chris Wedgwood <cw@f00f.org>
To: lyons@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: ioctl bug?
Message-ID: <20010714090130.A5737@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.33.0107131139450.12456-100000@gruel.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107131139450.12456-100000@gruel.uchicago.edu>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2001 at 03:43:15PM -0500, Gary Lyons wrote:

    starting with 2.4.5ac23 and continuing through both 2.4.6 and
    2.v.6-ac2 Whenever I try to do a lsattr or chattr on a directory
    I get:
    
    	"Inappropriate ioctl for device While reading flags"
    
    on 2.4.5-ac19 I have no problem.
    
    My computer is a pentium 3 with an asus motherboard, i810E
    chipset,and ide drives.  running redhat 7.1 and the hard drive
    is WDC WD600AB
    
    I am more then happy to supply any more information if necessary
    and

what filesystem? ext2 I assume?



  --cw
