Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289015AbSANUIm>; Mon, 14 Jan 2002 15:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288974AbSANUH2>; Mon, 14 Jan 2002 15:07:28 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:15100 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S289003AbSANUGW>;
	Mon, 14 Jan 2002 15:06:22 -0500
Date: Mon, 14 Jan 2002 13:06:12 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Michael Zhu <mylinuxk@yahoo.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "dd" collapsed the loop device
Message-ID: <20020114130612.Q26688@lynx.adilger.int>
Mail-Followup-To: Michael Zhu <mylinuxk@yahoo.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020114111843.P26688@lynx.adilger.int> <20020114184010.66277.qmail@web14908.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020114184010.66277.qmail@web14908.mail.yahoo.com>; from mylinuxk@yahoo.ca on Mon, Jan 14, 2002 at 01:40:10PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 14, 2002  13:40 -0500, Michael Zhu wrote:
> That means that I couldn't access /dev/fd0 directly
> when I use it via loopback? Is there any way that I
> can use to avoid this accident erase?

Now that you know it is bad, don't do that.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

