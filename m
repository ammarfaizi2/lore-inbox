Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290333AbSBFIzB>; Wed, 6 Feb 2002 03:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290338AbSBFIyv>; Wed, 6 Feb 2002 03:54:51 -0500
Received: from dsl-213-023-043-188.arcor-ip.net ([213.23.43.188]:9905 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S290333AbSBFIyk>;
	Wed, 6 Feb 2002 03:54:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: dipankar@in.ibm.com
Subject: Re: [PATCH] New Read-Copy Update patch
Date: Wed, 6 Feb 2002 09:58:31 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        Rusty Russell <rusty@rustcorp.com.au>,
        Paul McKenney <paul.mckenney@us.ibm.com>
In-Reply-To: <20020205211826.B32506@in.ibm.com> <E16YNgv-0002MZ-00@starship.berlin> <20020206142303.A1627@in.ibm.com>
In-Reply-To: <20020206142303.A1627@in.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16YNuR-0002Ml-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 6, 2002 09:53 am, Dipankar Sarma wrote:
> On Wed, Feb 06, 2002 at 09:44:33AM +0100, Daniel Phillips wrote:
> > On February 5, 2002 07:34 pm, Dipankar Sarma wrote:
> > >
> > > + * Based on the original work by Paul McKenney <paul.mckenney@us.ibm.com>
> > > + * and inputs from Andrea Arcangeli, Rusty Russell, Andi Kleen etc.
> > > + * Papers:
> > > + * http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
> > 
> > $ wget http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
> > --09:40:31--  http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
> >            => `rclockpdcsproof.pdf'
> > Connecting to www.rdrop.com:80... connected!
> > HTTP request sent, awaiting response... 403 Forbidden
> > 09:40:32 ERROR 403: Forbidden.
> > 
> > > + * http://lse.sourceforge.net/locking/rclock_OLS.2001.05.01c.sc.pdf (OLS2001)
> > 
> > $ wget http://lse.sourceforge.net/locking/rclock_OLS.2001.05.01c.sc.pdf
> > --09:41:59--  http://lse.sourceforge.net/locking/rclock_OLS.2001.05.01c.sc.pdf
> >            => `rclock_OLS.2001.05.01c.sc.pdf'
> > Connecting to lse.sourceforge.net:80... connected!
> > HTTP request sent, awaiting response... 404 Not Found
> > 09:41:59 ERROR 404: Not Found.
> > 
> > -- 
> > Daniel
> 
> Could you try this for the original paper -
> 
> http://www.rdrop.com/users/paulmck/rclock/rclockpdcsproof.pdf
> 
> Looks like Paul has rearranged his paper site.
> 
> And I messed up while rearranging the stuff in LSE. I have now restored
> the link to the OLS paper. Could you please retry ?

Both work fine.

> Sorry about the inconvenience.

No problem, thanks for the fixes!

-- 
Daniel
