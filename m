Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135975AbREGCHx>; Sun, 6 May 2001 22:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135976AbREGCHo>; Sun, 6 May 2001 22:07:44 -0400
Received: from babylon5.babcom.com ([216.36.71.34]:37760 "EHLO
	babylon5.babcom.com") by vger.kernel.org with ESMTP
	id <S135975AbREGCH2>; Sun, 6 May 2001 22:07:28 -0400
Date: Sun, 6 May 2001 19:07:21 -0700
From: Phil Stracchino <alaric@babcom.com>
To: God <atm@sdk.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernelnotes.org down / loop device results
Message-ID: <20010506190721.A3719@babylon5.babcom.com>
Mail-Followup-To: God <atm@sdk.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0105061522440.23642-100000@scotch.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0105061522440.23642-100000@scotch.homeip.net>; from atm@sdk.ca on Sun, May 06, 2001 at 09:32:28PM -0400
X-No-Archive: Yes
X-PGP-Fingerprint: 2105 C6FC 945D 2A7A 0738  9BB8 D037 CE8E EFA1 3249
X-PGP-Key-FTP-URL: ftp://ftp.babcom.com/pub/pgpkeys/alaric.asc
X-PGP-Key-HTTP-URL: http://www.babcom.com/alaric/pgp.html
X-Copyright: This message may not be reproduced, in part or in whole, for any commercial purpose without prior written permission.  Prior permission for securityfocus.com is implicit.
X-UCE-Policy: No unsolicited commercial email is accepted at this site.  The sending of any UCE to this domain may result in the imposition of civil liability against the sender in accordance with Cal. Bus. & Prof. Code Section 17538.45, and all senders of UCE will be permanently blocked.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2001 at 09:32:28PM -0400, God wrote:
> If I make an image of a floppy:
> then try to mount the image (no errors on the floppy):
> Mount hangs ...  what do I mean by that? .. well:

> box:
> Red Nut 7.1,
> Linux scotch 2.4.2 #2 SMP Thu Mar 1 18:08:51 EST 2001 i686 unknown


This is a known problem in the 2.4.2 kernel.  It's fixed in 2.4.3.


-- 
 Linux Now!   ..........Because friends don't let friends use Microsoft.
 phil stracchino   --   the renaissance man   --   mystic zen biker geek
    Vr00m:  2000 Honda CBR929RR   --   Cage:  2000 Dodge Intrepid R/T
 Previous vr00mage:  1986 VF500F (sold), 1991 VFR750F3 (foully murdered)
