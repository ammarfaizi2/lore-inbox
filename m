Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129465AbQLTSX3>; Wed, 20 Dec 2000 13:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129828AbQLTSXJ>; Wed, 20 Dec 2000 13:23:09 -0500
Received: from moot.mb.ca ([64.4.83.10]:32521 "EHLO moot.cdir.mb.ca")
	by vger.kernel.org with ESMTP id <S129465AbQLTSXA>;
	Wed, 20 Dec 2000 13:23:00 -0500
Date: Wed, 20 Dec 2000 11:52:26 -0600 (CST)
From: "Michael J. Dikkema" <mjd@moot.ca>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 question (fh_lock_parent)
In-Reply-To: <14911.53776.854761.710519@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.21.0012201151330.7919-100000@sliver.moot.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Apparently in the init scripts, sendmail starts before mounting /dev/sda1
.. but it never happened before changing kernels.. that's why it was using
nfs instead of the scsi disk. (I'm smrt.)

Thanks for the help though. :)

,.;::
: Michael J. Dikkema
| Systems / Network Admin - Internet Solutions, Inc.
| http://www.moot.ca   Work: (204) 982-1060
; mjd@moot.ca
',.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
