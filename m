Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264451AbRFIKMF>; Sat, 9 Jun 2001 06:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264452AbRFIKLz>; Sat, 9 Jun 2001 06:11:55 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:27140 "HELO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with SMTP
	id <S264451AbRFIKLq>; Sat, 9 Jun 2001 06:11:46 -0400
Message-ID: <22F662CDC53ED411B65700805F31DE1C135A70@exccop-01.dmo.cpqcorp.net>
From: "Mathiasen, Torben" <Torben.Mathiasen@COMPAQ.COM>
To: "'Paulo Afonso Graner Fessel'" <pafessel@zaz.com.br>,
        linux-kernel@vger.kernel.org
Cc: hollis@austin.rr.com
Subject: RE: Probable endianess problem in TLAN driver
Date: Sat, 9 Jun 2001 11:11:36 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo,

Thanks for the update/patch. Sorry I missed your first email, bu I've been
way too busy with other stuff the last couple of months.

There's a lot of endianess issues in the tlan driver, but none really
bothered fixing them. No one really assumed the tlan adapters would be used
on bigendian machines. Well, let me say, you're probaly the first ;-).

Now, I have pile of updates/issues for the tlan driver I need to check up
on. Hopefully I'll have some sparetime within a reasonable future to address
this.

BTW. The project page on compaq.com is the "new" tlan site.

Thanks,

Torben Mathiasen

