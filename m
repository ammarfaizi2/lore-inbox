Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132010AbRAEPfe>; Fri, 5 Jan 2001 10:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132074AbRAEPfY>; Fri, 5 Jan 2001 10:35:24 -0500
Received: from AStrasbourg-201-2-1-11.abo.wanadoo.fr ([193.251.1.11]:26897
	"EHLO lune.perinfo.com") by vger.kernel.org with ESMTP
	id <S132010AbRAEPfI>; Fri, 5 Jan 2001 10:35:08 -0500
Message-ID: <000d01c07724$8fa531f0$8900030a@nicolasp>
From: "Nicolas Parpandet" <nparpand@perinfo.com>
To: <linux-kernel@vger.kernel.org>
Subject: kernel network problem ?
Date: Fri, 5 Jan 2001 15:34:07 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I'm testing 2.4 series for few weeks,
even the last prerelease

I've seen stranges things  :

I cannot access to some ips adresses ! :
in http or in smtp using "konqueror", "netscape",
"mail",  "telnet 25".

I cannot login to hotmail (in the web page:http) 
or send mail (smtp) to hotmail users (don't blame me !!)
All the others network things works well, the network in general seems
good only very few sites like hotmail doesn't works.

And only with 2.4 series !! not with 2.2 ...

maybe it's a glibc or kernel issue, I'dont know.
I have an intel SMP motherboard connected to the net (cable) 
with a PCI realtek 8019.

I didn't analyse packets sent. If somebody else have the
same problems ...

Nicolas.

Sorry for my poor english.

PS: funny "bug" isn't it ? (hotmail !)
PS2: thanks for all, very good job done, 
      2.4 is very fast and seems stable.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
