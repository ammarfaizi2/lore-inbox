Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129316AbQKTVs7>; Mon, 20 Nov 2000 16:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129189AbQKTVst>; Mon, 20 Nov 2000 16:48:49 -0500
Received: from pC19F09A7.dip.t-dialin.net ([193.159.9.167]:22260 "EHLO
	mail.linsoft.de") by vger.kernel.org with ESMTP id <S129170AbQKTVsg> convert rfc822-to-8bit;
	Mon, 20 Nov 2000 16:48:36 -0500
From: Oliver Poths <oliver.poths@linsoft.de>
Date: Mon, 20 Nov 2000 21:18:18 GMT
Message-ID: <20001120.21181800@rock.>
Subject: kernel 2.4.0-test11 crash (raid-code?) additional information
To: linux-kernel@vger.kernel.org
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2;Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just like the first time after the kernel crashed, i pressed 
ctrl-alt-del, then another oops-message appeared.
After that i could only switch the system off. Reboot with the same result 
--> power off.
Switching on again (3rd time) --> system boots!!!
But again the kernel says at ide2, ide3 and ide4: Bios settings: hde:pio.
Now, when i boot next time the Bios settings will be dma again.

Best regards,
Oliver Poths

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
