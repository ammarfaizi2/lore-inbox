Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130336AbRABOIq>; Tue, 2 Jan 2001 09:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130461AbRABOI1>; Tue, 2 Jan 2001 09:08:27 -0500
Received: from [212.28.148.18] ([212.28.148.18]:55406 "HELO
	toe1.terreactive.ch") by vger.kernel.org with SMTP
	id <S130336AbRABOIQ>; Tue, 2 Jan 2001 09:08:16 -0500
Message-ID: <3A51D98E.E5689EB6@tac.ch>
Date: Tue, 02 Jan 2001 14:37:18 +0100
From: ratz <ratz@tac.ch>
Organization: terreActive
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en, de-CH, zh-CN
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: devices.txt inconsistency
In-Reply-To: <20010101170654.A5856@sourceware.net> <20010101232454.C8481@tenchi.datarithm.net> <92r50r$5vq$1@cesium.transmeta.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The current devices.txt is available at:
> 
>    http://www.lanana.org/docs/device-list/devices.txt
> 
> I don't have the details for /dev/input/* in there; I need to still
> make that update.

Small typo fix:

--- devices.txt~	Tue Jan  2 14:34:32 2001
+++ devices.txt	Tue Jan  2 14:34:48 2001
@@ -771,7 +771,7 @@
  36 char	Netlink support
 		  0 = /dev/route	Routing, device updates, kernel to user
 		  1 = /dev/skip		enSKIP security cache control
-		  3 = /dec/fwmonitor	Firewall packet copies
+		  3 = /dev/fwmonitor	Firewall packet copies
 		 16 = /dev/tap0		First Ethertap device
 		    ...
 		 31 = /dev/tap15	16th Ethertap device

Regards,
Roberto Nibali, ratz

-- 
mailto: `echo NrOatSz@tPacA.cMh | sed 's/[NOSPAM]//g'`
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
