Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129145AbQKSXvq>; Sun, 19 Nov 2000 18:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129572AbQKSXvh>; Sun, 19 Nov 2000 18:51:37 -0500
Received: from usuario1-36-191-31.dialup.uni2.es ([62.36.191.31]:6916 "HELO
	zaknafein.net.dhis.org") by vger.kernel.org with SMTP
	id <S129145AbQKSXv3>; Sun, 19 Nov 2000 18:51:29 -0500
Date: Mon, 20 Nov 2000 00:10:42 +0100
From: Drizzt <drizzt.dourden@iname.com>
To: linux-kernel@vger.kernel.org
Subject: USB Mass Storage and test11pre7
Message-ID: <20001120001042.A777@menzoberrazan.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have testing a HP 8200e USB CDRW Driver with this version of kernel.

With the vainilla test10, after wrinting 14 MB, the cdrecotrd proccess lock, 
and I have the next messsage imn the logs:

Nov 19 22:35:34 localhost kernel: usb_control/bulk_msg: timeout

These doesn't happen with test10. But I only have success with the test10 with
1 cdrom. With Windows and Nero no problems burning cd ( I test for hardware
problems). How I can help debug these issue.

Saludos
Drizzt

-- 
... No es oro todo lo que reluce, ni toda la gente errante anda perdida.
____________________________________________________________________________
Drizzt Do'Urden                Three rings for the Elves Kings under the Sky   
drizzt.dourden@iname.com       Seven for the Dwarf_lords in their  
                               hall of stone
                               Nine for the Mortal Men doomed to die 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
