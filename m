Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130497AbRBWWLc>; Fri, 23 Feb 2001 17:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130542AbRBWWLX>; Fri, 23 Feb 2001 17:11:23 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:47622 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S130497AbRBWWLS>; Fri, 23 Feb 2001 17:11:18 -0500
Date: Fri, 23 Feb 2001 17:10:46 -0500
From: Chris Mason <mason@suse.com>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs: still problems with tail conversion
Message-ID: <730960000.982966246@tiny>
In-Reply-To: <20010223221856.A24959@arthur.ubicom.tudelft.nl>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, February 23, 2001 10:18:56 PM +0100 Erik Mouw
<J.A.K.Mouw@ITS.TUDelft.NL> wrote:

> Hi all,
> 
> I am running linux-2.4.2-pre4 with Chris Mason's tailconversion bug fix
> applied, but I still have problems with null bytes in files. I wrote a
> little test program that clearly shows the problem:
> 

Many thanks for sending along a test program for reproducing.  But, it
doesn't seem to reproduce the problem here, how many times did you have to
run it to see the null bytes?  Do you remove the files between runs?

-chris

