Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129304AbRBDRCz>; Sun, 4 Feb 2001 12:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131832AbRBDRCp>; Sun, 4 Feb 2001 12:02:45 -0500
Received: from mail.diligo.fr ([194.153.78.251]:47370 "EHLO mail.diligo.fr")
	by vger.kernel.org with ESMTP id <S129304AbRBDRC3>;
	Sun, 4 Feb 2001 12:02:29 -0500
Date: Sun, 4 Feb 2001 17:58:38 +0100
From: patrick.mourlhon@wanadoo.fr
To: linux-kernel@vger.kernel.org
Subject: Re: ATAPI CDRW which doesn't work
Message-ID: <20010204175838.A2123@MourOnLine.dnsalias.org>
Reply-To: patrick.mourlhon@wanadoo.fr
In-Reply-To: <20010203230544.A549@MourOnLine.dnsalias.org> <20010204030644.A23913@l-t.ee> <20010204073352.A529@MourOnLine.dnsalias.org> <20010204172220.B19909@l-t.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010204172220.B19909@l-t.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I've got those kind of message now :
> > 
> > Feb  4 07:18:35 Line kernel: scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 00 00 2e 00 00 01 00 
> 
> If this is a correct ISO9660 cd you should not see those
> messages.  It is either hardware problem (eg IDE cable is badly
> conencted or CDRW is broken/dusty) or this CD is simply
> scratched.  Does it work with another CD?
> 
> Also try to put it on separate IDE channel than your main HD.

Cable looks ok, removed and reinstalled, used it before with 
a second hard disk. CDRW may be broken. don't know, but at
least nothing appear broken all around the device.
CD was read with an other CDROM reader.
Never seen CDRW working reliably till now. But never used it
through Windows, don't have it since 4 years. I might at least
check if it could work on Windows.

Whatever thanks a lot for your time, was greatly appreciated,

patrick
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
