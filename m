Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQKDTna>; Sat, 4 Nov 2000 14:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129313AbQKDTnU>; Sat, 4 Nov 2000 14:43:20 -0500
Received: from madjfppp.jazztel.es ([212.106.224.15]:2820 "HELO
	roku.redroom.com") by vger.kernel.org with SMTP id <S129103AbQKDTnI> convert rfc822-to-8bit;
	Sat, 4 Nov 2000 14:43:08 -0500
From: davidge@jazzfree.com
Date: Sat, 4 Nov 2000 20:43:04 +0100 (CET)
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: trying to read cd info
Message-ID: <Pine.LNX.4.10.10011042022460.3881-100000@roku.redroom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I'm trying to read application id, volume id and stuff from cds, but 
don't figure out how to do it. It looks like ioctls CDROMREADMODE1 /
CDROMREADMODE2 may be the way to do it, but the kernel show a read error
when i try to read the data. What is needed in the struct cdrom_read to
make the ioctl works? And if i'm wrong, and that's very likely ;), what's
it the way to obtain these data from the cd?

tia


David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
