Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269883AbRHEA4D>; Sat, 4 Aug 2001 20:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269885AbRHEAzx>; Sat, 4 Aug 2001 20:55:53 -0400
Received: from femail18.sdc1.sfba.home.com ([24.0.95.145]:11217 "EHLO
	femail18.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S269883AbRHEAzi>; Sat, 4 Aug 2001 20:55:38 -0400
Date: Sat, 4 Aug 2001 20:55:37 -0400
From: Tom Vier <tmv5@home.com>
To: Matthew Gardiner <kiwiunixman@yahoo.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7-ac4 disk thrashing
Message-ID: <20010804205537.A17307@zero>
In-Reply-To: <20010804113841.A2196@zero> <3B6C7F9B.30303@yahoo.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B6C7F9B.30303@yahoo.co.nz>; from kiwiunixman@yahoo.co.nz on Sun, Aug 05, 2001 at 11:04:59AM +1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2001 at 11:04:59AM +1200, Matthew Gardiner wrote:
> Tom Vier wrote:
> >switching from 2.4.7-ac3 to -ac4, disk access seems to be much more
> >synchronis. running a ./configure script causes all kinds of trashing, as
> >does installing .debs. i'm using reiserfs on top of software raid 0 on an
> >alpha.

> Apparently, in ac5 (which I am running), there was a bug on non-x86 
> cpu's using reiserfs. Download and install the new patch and try.

that's just a signedness fix. i've tried ac5 and it has the same problem as
ac4.

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
