Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267940AbRG2LKQ>; Sun, 29 Jul 2001 07:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267942AbRG2LKG>; Sun, 29 Jul 2001 07:10:06 -0400
Received: from weta.f00f.org ([203.167.249.89]:19846 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S267940AbRG2LJr>;
	Sun, 29 Jul 2001 07:09:47 -0400
Date: Sun, 29 Jul 2001 23:10:23 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Matthew Gardiner <kiwiunixman@yahoo.co.nz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Philip R. Auld" <pauld@egenera.com>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <20010729231023.C3917@weta.f00f.org>
In-Reply-To: <E15QWto-0007r1-00@the-village.bc.nu> <01072922150300.03891@kiwiunixman.nodomain.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01072922150300.03891@kiwiunixman.nodomain.nowhere>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, Jul 29, 2001 at 10:15:03PM +1200, Matthew Gardiner wrote:

    tsk tsk tsk. A bit disappointing that Vertias has taken that approach. 
    However, even still, reiserFS is pretty awsome. Extremely fast and space 
    efficient, esp on a 60gig drive ;)

Why "tsk tsk tsk" ?  If reiserfs suits you, use it --- you need never
go near VXFS.

Personally, even though I use reiserfs, I am of the opinion that XFS,
and VXFS and both superior, especially when you include volume
management.  Time will show whether or not these very well designed
file-systems are suitable under Linux though, as reiserfs has a
considerable head start.



  --cw
