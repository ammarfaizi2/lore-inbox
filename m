Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129959AbQKGWad>; Tue, 7 Nov 2000 17:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129958AbQKGWaX>; Tue, 7 Nov 2000 17:30:23 -0500
Received: from Host4.modempool1.milfordcable.net ([206.72.42.4]:5892 "HELO
	windeath.2y.net") by vger.kernel.org with SMTP id <S129957AbQKGWaN>;
	Tue, 7 Nov 2000 17:30:13 -0500
Message-ID: <3A088352.BCAD0B7A@windeath.2y.net>
Date: Tue, 07 Nov 2000 16:33:54 -0600
From: James M <dart@windeath.2y.net>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re:test11-pre1 - Parport/IMM/Zip Oops fixed
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   My previously reported Parport/Zip Oops seems to have gone away. I
suspect the SMP race fixs were the culprit...thank you.
   However my parport is still misdetected as SPP by the IMM driver when
it is actually set to EPP. This is an Epox/SMP Xeon (400 mhz), EP-GXB-M
with an Award Bios and Winbond Super I/O Multi controller.
   
   Now if we could just do something about those 10 fps in quake that I
lost since 2.3.4x....;=)

James M.
aka "Dart"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
