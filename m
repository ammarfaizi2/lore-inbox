Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267494AbTAGSrh>; Tue, 7 Jan 2003 13:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267495AbTAGSrg>; Tue, 7 Jan 2003 13:47:36 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:50420 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S267494AbTAGSre>; Tue, 7 Jan 2003 13:47:34 -0500
Date: Tue, 7 Jan 2003 11:55:44 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Max Valdez <maxvaldez@yahoo.com>, Jan Hudec <bulb@ucw.cz>,
       kernel <linux-kernel@vger.kernel.org>
Subject: Re: Undelete files on ext3 ??
Message-ID: <20030107115544.W31555@schatzie.adilger.int>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Max Valdez <maxvaldez@yahoo.com>, Jan Hudec <bulb@ucw.cz>,
	kernel <linux-kernel@vger.kernel.org>
References: <1041961118.13635.10.camel@garaged.fis.unam.mx> <Pine.LNX.3.95.1030107131613.3523A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.95.1030107131613.3523A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Tue, Jan 07, 2003 at 01:17:35PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 07, 2003  13:17 -0500, Richard B. Johnson wrote:
> Therefore, it's time for somebody to put a 'dumpster` in all the Linux
> file-systems.  Somebody should then modify `rm` and the kernel unlink
> to `mv' files to the dumpster directory on the file-system, instead of
> really deleting them. Then, just like the Redmond stuff, a separate
> program can be used to clear out the "dumpster" or `mv` them back.

This is very FAQ.  Please see the l-k archives for any year to find
lengthy discussions about this.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

