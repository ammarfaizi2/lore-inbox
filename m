Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129417AbRBKONT>; Sun, 11 Feb 2001 09:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129482AbRBKONJ>; Sun, 11 Feb 2001 09:13:09 -0500
Received: from kamov.deltanet.ro ([193.226.175.59]:35856 "HELO
	kamov.deltanet.ro") by vger.kernel.org with SMTP id <S129417AbRBKOM6>;
	Sun, 11 Feb 2001 09:12:58 -0500
Date: Sun, 11 Feb 2001 16:12:42 +0200
From: Petru Paler <ppetru@ppetru.net>
To: linux-kernel@vger.kernel.org
Subject: RAID1 read balancing
Message-ID: <20010211161242.A949@ppetru.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

For a RAID1 array built of two disks on two separate SCSI controllers,
are the reads balanced between the two controllers (for higher speed) ?

--
Petru Paler, mailto:ppetru@ppetru.net
http://www.ppetru.net - ICQ: 41817235
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
