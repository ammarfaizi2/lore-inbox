Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131721AbRADMBW>; Thu, 4 Jan 2001 07:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132428AbRADMBM>; Thu, 4 Jan 2001 07:01:12 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:29963 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131721AbRADMBB>;
	Thu, 4 Jan 2001 07:01:01 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: sidb@FreeNet.co.uk
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: prerelease-ac5 make dep error 
In-Reply-To: Your message of "Thu, 04 Jan 2001 10:27:59 -0000."
             <3A54502F.6039978E@FreeNet.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Jan 2001 23:00:54 +1100
Message-ID: <6343.978609654@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jan 2001 10:27:59 +0000, 
Sid Boyce <sidb@FreeNet.co.uk> wrote:
>	Just seen this on UP kernel build.....
>/usr/src/linux/Rules.make:224: *** Recursive variable `CFLAGS'
>references itself (eventually).  Stop.

What does make --version report?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
