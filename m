Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273978AbRIXQIg>; Mon, 24 Sep 2001 12:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273980AbRIXQIa>; Mon, 24 Sep 2001 12:08:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28689 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S273978AbRIXQIM>;
	Mon, 24 Sep 2001 12:08:12 -0400
Date: Mon, 24 Sep 2001 17:08:29 +0100
From: Chris Dukes <pakrat@www.uk.linux.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
Message-ID: <20010924170829.A13630@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
	linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <20010924174745.A8230@emma1.emma.line.org> <E15lYHC-0002zc-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15lYHC-0002zc-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Sep 24, 2001 at 05:08:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 05:08:10PM +0100, Alan Cox wrote:
> > Those drives should be blacklisted and rejected as soon as someone tries
> > to mount those pieces rw. Either the drive can make guarantees when a
> > write to permanent storage has COMPLETED (either by switching off the
> > cache or by a flush operation) or it belongs ripped out of the boxes and
> > stuffed down the throat of the idiot who built it.
> 
> In which case you can choose between ancient ST-506 drives and SCSI

I thought that Andre had some information as to which devices were
compliant and which weren't.

-- 
Chris Dukes
The law is a code that isolates justice from public participation. 
 -- Stephen Marhall
