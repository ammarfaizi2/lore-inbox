Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137082AbREKJZU>; Fri, 11 May 2001 05:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137085AbREKJZK>; Fri, 11 May 2001 05:25:10 -0400
Received: from oxmail1.ox.ac.uk ([129.67.1.1]:41404 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S137082AbREKJZC>;
	Fri, 11 May 2001 05:25:02 -0400
Date: Fri, 11 May 2001 10:21:09 +0100
From: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Not a typewriter
Message-ID: <20010511102109.A18500@sable.ox.ac.uk>
In-Reply-To: <Pine.GSO.4.21.0105102001000.3943-100000@weyl.math.psu.edu> <p0510030eb720f425344e@[10.128.7.49]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <p0510030eb720f425344e@[10.128.7.49]>; from jlundell@pobox.com on Thu, May 10, 2001 at 07:01:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Lundell writes:
> FWIW, the comment in errno.h under Solaris 2.6 is "Inappropriate 
> ioctl for device". I believe that's the POSIX interpretation.

POSIX has

  [ENOTTY]  Inappropriate I/O control operation
            A control function was attempted for a file or special file
            for which the operation was inappropriate.

which is quite a nice way of putting it.

--Malcolm

-- 
Malcolm Beattie <mbeattie@sable.ox.ac.uk>
Unix Systems Programmer
Oxford University Computing Services
