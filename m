Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290312AbSBFIvb>; Wed, 6 Feb 2002 03:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290333AbSBFIvY>; Wed, 6 Feb 2002 03:51:24 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:46037 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S290312AbSBFIvJ>;
	Wed, 6 Feb 2002 03:51:09 -0500
Date: Wed, 6 Feb 2002 14:23:03 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        Rusty Russell <rusty@rustcorp.com.au>,
        Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: [PATCH] New Read-Copy Update patch
Message-ID: <20020206142303.A1627@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020205211826.B32506@in.ibm.com> <20020205181354.M3135@athlon.random> <20020206000420.B427@in.ibm.com> <E16YNgv-0002MZ-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16YNgv-0002MZ-00@starship.berlin>; from phillips@bonn-fries.net on Wed, Feb 06, 2002 at 09:44:33AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 09:44:33AM +0100, Daniel Phillips wrote:
> On February 5, 2002 07:34 pm, Dipankar Sarma wrote:
> >
> > + * Based on the original work by Paul McKenney <paul.mckenney@us.ibm.com>
> > + * and inputs from Andrea Arcangeli, Rusty Russell, Andi Kleen etc.
> > + * Papers:
> > + * http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
> 
> $ wget http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
> --09:40:31--  http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
>            => `rclockpdcsproof.pdf'
> Connecting to www.rdrop.com:80... connected!
> HTTP request sent, awaiting response... 403 Forbidden
> 09:40:32 ERROR 403: Forbidden.
> 
> > + * http://lse.sourceforge.net/locking/rclock_OLS.2001.05.01c.sc.pdf (OLS2001)
> 
> $ wget http://lse.sourceforge.net/locking/rclock_OLS.2001.05.01c.sc.pdf
> --09:41:59--  http://lse.sourceforge.net/locking/rclock_OLS.2001.05.01c.sc.pdf
>            => `rclock_OLS.2001.05.01c.sc.pdf'
> Connecting to lse.sourceforge.net:80... connected!
> HTTP request sent, awaiting response... 404 Not Found
> 09:41:59 ERROR 404: Not Found.
> 
> -- 
> Daniel

Could you try this for the original paper -

http://www.rdrop.com/users/paulmck/rclock/rclockpdcsproof.pdf

Looks like Paul has rearranged his paper site.

And I messed up while rearranging the stuff in LSE. I have now restored
the link to the OLS paper. Could you please retry ?

Sorry about the inconvenience.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
