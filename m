Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285099AbRLUULx>; Fri, 21 Dec 2001 15:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285127AbRLUULr>; Fri, 21 Dec 2001 15:11:47 -0500
Received: from cs136068.pp.htv.fi ([213.243.136.68]:16000 "EHLO
	limbo.dnsalias.org") by vger.kernel.org with ESMTP
	id <S285125AbRLUULg>; Fri, 21 Dec 2001 15:11:36 -0500
Date: Fri, 21 Dec 2001 22:11:31 +0200 (EET)
From: Timo Jantunen <jeti@iki.fi>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
In-Reply-To: <20011221141847.E15926@redhat.com>
Message-ID: <Pine.LNX.4.33.0112212151380.928-100000@limbo.dnsalias.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2001, Benjamin LaHaise wrote:

> So, encouraging non-uniform terminology, breaking applicates *and*
> confusing the hell out of everyone is better?  Face it, the only people
> trying to confuse things are the disk vendors.  DRAM is sold by the MB,
> everyone talks about MB == 1024*1024...  I'm having a hard time giving a
> sympathetic ear to anyone try to change the well established, and
> consistent (barring the storage venduhs), standard.

And disk vendors aren't even consistant! At least my 30 GB and 40 GB drives 
have 60036480 and 80418240 sectors, respectively (512 bytes each).

That computes to 30.7*10^9 and 41.2*10^9 or 28.6*2^30 and 38.3*2^30 bytes.

If you want numbers near 30 and 40 you need to calculate 30.0*10^6*2^10 and 
40.2*10^6*2^10!


And as somebody else pointed out, 1 Mbit/s line is't 10^6 bit/s nor 2^20 
bit/s line, either, a but 1024000 bit/s line.

=> Even if Configure.help would use kiB, MiB, GiB etc. it wouldn't remove 
many of the ambiguities. Is it worth the pain?


> 		-ben

// /
....................................Timo Jantunen  .......................
       ZZZ      (Used to represent :Kuunsäde 8 A 28: Email: jeti @iki.fi :
the  sound of  a person  snoring.) :02210 Espoo    : http://iki.fi/jeti  :
Webster's  Encyclopedic Unabridged :Finland        : GSM +358-40-5763131 :
Dictionary of the English Language :...............:.....................:


