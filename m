Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263362AbTCNNvm>; Fri, 14 Mar 2003 08:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263363AbTCNNvl>; Fri, 14 Mar 2003 08:51:41 -0500
Received: from mgw-x1.nokia.com ([131.228.20.21]:11997 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id <S263362AbTCNNvk>;
	Fri, 14 Mar 2003 08:51:40 -0500
Message-ID: <3E71E179.20408@nokia.com>
Date: Fri, 14 Mar 2003 16:04:41 +0200
From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Affix Support DL <affix-support@lists.sourceforge.net>,
       Affix Devel DL <affix-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: affix-2.0.0-pre2 and affix-kernel-2.0.0-pre2 releases
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Mar 2003 14:01:58.0986 (UTC) FILETIME=[4792C2A0:01C2EA32]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Affix 2.0.0-pre2 released
http://affix.sourceforge.net

- looks stable, and everything is working now.
- NEW: Working Aydio -> see btmpg123 in source package how to listen mp3
- NEW: DUN GW with real modem support.
- NEW: Fax Profile from Christian Plog

Now available profiles:
- General Access Profie
- Service Discovery Profile
- Serial Port Profile
- DialUp Networking Profile (real)
- DialUp Networking Profile (emulation)
- LAN Access Profile
- OBEX Object Push Profile
- OBEX File Transfer Profile
- PAN Profile
- FAX Profile

affix-kernel-2.0.0-pre2 [14.03.2003]
- [fix] pre1 -> pre2 fixes. everything works.
- [new] ability to compile with external PCMCIA package


affix-2.0.0-pre2 [14.03.2003]
- [new] Complete Audio Support -> can play MP3 on your headset
	see btmpg123 script
- [new] FAX profile from Christian Plog
- [new] real DUN profile -> works with real modem.
- [fix] pre1 -> pre2 fixes. everything works.
- [new] Redhat init.d stcript.
- [new] affix.conf has extra options: load_modules and audio.



br, Dmitry


br, Dmitry

-- 
        Dmitry Kasatkin
        Nokia Research Center / Helsinki
        *Affix* Project Leader (http://affix.sourceforge.net)
        Mobile: +358 50 4836365
         E-Mail: dmitry.kasatkin@nokia.com








-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T
handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
_______________________________________________
Affix-devel mailing list
Affix-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/affix-devel




