Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAENA1>; Fri, 5 Jan 2001 08:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbRAENAK>; Fri, 5 Jan 2001 08:00:10 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:11534
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129383AbRAEM7w>; Fri, 5 Jan 2001 07:59:52 -0500
Date: Sat, 6 Jan 2001 01:59:49 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andreas Dilger <adilger@turbolinux.com>,
        Daniel Phillips <phillips@innominate.de>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
Message-ID: <20010106015949.B691@metastasis.f00f.org>
In-Reply-To: <200101050800.f0580He12396@webber.adilger.net> <E14EWGE-0007bW-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14EWGE-0007bW-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jan 05, 2001 at 12:46:19PM +0000
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 12:46:19PM +0000, Alan Cox wrote:

    Which means an ext3 volume cannot be recovered on a hard disk
    error.

So you have to run e3fsck or similar then one assumes.


  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
