Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290306AbSBFIkJ>; Wed, 6 Feb 2002 03:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290309AbSBFIj7>; Wed, 6 Feb 2002 03:39:59 -0500
Received: from dsl-213-023-043-188.arcor-ip.net ([213.23.43.188]:689 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S290306AbSBFIjv>;
	Wed, 6 Feb 2002 03:39:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: dipankar@in.ibm.com, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] New Read-Copy Update patch
Date: Wed, 6 Feb 2002 09:44:33 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
        Paul McKenney <paul.mckenney@us.ibm.com>
In-Reply-To: <20020205211826.B32506@in.ibm.com> <20020205181354.M3135@athlon.random> <20020206000420.B427@in.ibm.com>
In-Reply-To: <20020206000420.B427@in.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16YNgv-0002MZ-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 5, 2002 07:34 pm, Dipankar Sarma wrote:
>
> + * Based on the original work by Paul McKenney <paul.mckenney@us.ibm.com>
> + * and inputs from Andrea Arcangeli, Rusty Russell, Andi Kleen etc.
> + * Papers:
> + * http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf

$ wget http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
--09:40:31--  http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
           => `rclockpdcsproof.pdf'
Connecting to www.rdrop.com:80... connected!
HTTP request sent, awaiting response... 403 Forbidden
09:40:32 ERROR 403: Forbidden.

> + * http://lse.sourceforge.net/locking/rclock_OLS.2001.05.01c.sc.pdf (OLS2001)

$ wget http://lse.sourceforge.net/locking/rclock_OLS.2001.05.01c.sc.pdf
--09:41:59--  http://lse.sourceforge.net/locking/rclock_OLS.2001.05.01c.sc.pdf
           => `rclock_OLS.2001.05.01c.sc.pdf'
Connecting to lse.sourceforge.net:80... connected!
HTTP request sent, awaiting response... 404 Not Found
09:41:59 ERROR 404: Not Found.

-- 
Daniel
