Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135333AbRAVWtD>; Mon, 22 Jan 2001 17:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131355AbRAVWsx>; Mon, 22 Jan 2001 17:48:53 -0500
Received: from purplecoder.com ([206.64.99.91]:14053 "EHLO
	gateway.purplecoder.com") by vger.kernel.org with ESMTP
	id <S130794AbRAVWso>; Mon, 22 Jan 2001 17:48:44 -0500
Message-ID: <3A6C6F74.4A022E12@purplecoder.com>
Date: Mon, 22 Jan 2001 12:35:48 -0500
From: Mark I Manning IV <mark4@purplecoder.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: Partition IDs in the New World TM
In-Reply-To: <UTC200101222242.XAA202146.aeb@vlet.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On a system with nothing but linux installed does partitioning slow
things down?  

I have...

/dev/hda1     93309     27520     60972  32% /
/dev/hda3   2885812   1042304   1696916  39% /usr
/dev/hda5   4806904   1989612   2573108  44% /home
/dev/hda6   4806904    913044   3649676  21% /var
/dev/hda7   4806904   1345696   3217024  30% /home/ftp
/dev/hda8   4806904   2170136   2392584  48%
/home/ftp/debian/dists/potato
/dev/hda9   4806904   1352776   3209944  30%
/home/ftp/debian/dists/woody
/dev/hda10  2284880    904832   1263980  42% /home/ftp/debian/pool
/dev/hdb1   3844584    721632   2927656  20% /home/shared
/dev/hdb2   3844616      4092   3645224   1% /home/ftp/debian/dists/sid

plus hdb3 not yet mounted anywhere
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
