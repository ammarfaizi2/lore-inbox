Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129441AbRBHWGz>; Thu, 8 Feb 2001 17:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129926AbRBHWGp>; Thu, 8 Feb 2001 17:06:45 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:58248 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129441AbRBHWG1>; Thu, 8 Feb 2001 17:06:27 -0500
Date: Thu, 8 Feb 2001 22:06:25 +0000 (GMT)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Doug Ledford <dledford@redhat.com>
cc: Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac7
In-Reply-To: <3A8314FB.373783C0@redhat.com>
Message-ID: <Pine.SOL.3.96.1010208220505.27924B-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Doug Ledford wrote:
> Thanks, I hoped it would ;-)  It's amazing what happens when you have a bcopy
> in assembly that's missing the source address initialization :-(

Yes! The output from the description of my SCSI hds when the driver
initialised was highly amusing (containing extremely random garbage)...
(-;

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
