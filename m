Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263294AbRFEH5Y>; Tue, 5 Jun 2001 03:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263295AbRFEH5P>; Tue, 5 Jun 2001 03:57:15 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:39919 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S263291AbRFEH5D>; Tue, 5 Jun 2001 03:57:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Svein Erik Brostigen <svein.brostigen@oracle.com>
To: Nick Urbanik <nicku@vtc.edu.hk>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Cannot mount old ext2 cdrom, but e2fsck shows no problems
Date: Tue, 5 Jun 2001 03:59:29 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <3B1C8C1B.E3946FE1@vtc.edu.hk>
In-Reply-To: <3B1C8C1B.E3946FE1@vtc.edu.hk>
MIME-Version: 1.0
Message-Id: <01060503592906.02249@sparkle.us.oracle.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 June 2001 03:36, Nick Urbanik wrote:

"Snip"

> I will be very grateful for any help that increases my understanding of
> what is going on.
>
> $ sudo mount -t ext2 /dev/scd0 /cdrom -o ro
Try -t iso9660

> mount: wrong fs type, bad option, bad superblock on /dev/scd0,
>        or too many mounted file systems

-- 
Regards
Svein Erik

Marriage is the only adventure open to the cowardly. - Voltaire 
_____________________________________________________________
Svein Erik Brostigen       e-mail: svein.brostigen@oracle.com
Senior Technical Analyst                  Phone: 407.458.7168
EBC - Extended Business Critical
Oracle Support Services   
5955 T.G. Lee Blvd
Orlando FL, 32822

Enabling the Information Age Through Internet Computing
_____________________________________________________________

The statements and opinions expressed here are my own and
do not necessarily represent those of Oracle Corporation.
