Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSEXWoi>; Fri, 24 May 2002 18:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSEXWoi>; Fri, 24 May 2002 18:44:38 -0400
Received: from mgw-x3.nokia.com ([131.228.20.26]:8683 "EHLO mgw-x3.nokia.com")
	by vger.kernel.org with ESMTP id <S312526AbSEXWog>;
	Fri, 24 May 2002 18:44:36 -0400
Message-ID: <3CEEC240.8030905@nokia.com>
Date: Sat, 25 May 2002 01:44:16 +0300
From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020412 Debian/0.9.9-6
X-Accept-Language: en
MIME-Version: 1.0
Newsgroups: comp.os.linux.networking
To: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
CC: affix-devel@lists.sourceforge.net,
        Affix support <affix-support@lists.sourceforge.net>,
        linux-net <linux-net@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: [new release] Affix-1_00pre1  --- Bluetooth Protocol Stack. + initial
 Audio Support
In-Reply-To: <3C500D09.4080206@nokia.com> <3C5AB093.5050405@nokia.com> <3C5E4991.6010707@nokia.com> <3C628D6A.2050900@nokia.com> <3C628DCF.40700@nokia.com> <3C6D25F6.4010905@nokia.com> <3C766511.5050808@nokia.com> <3C7F6C0C.6030204@nokia.com> <3C877AC7.8090008@nokia.com> <3C92111C.1070107@nokia.com> <3CA3A149.1080905@nokia.com> <3CAE2484.8090304@nokia.com> <3CB99689.7090105@nokia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 May 2002 22:44:35.0247 (UTC) FILETIME=[93E9FBF0:01C20374]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All.
  
Find new Affix release Affix-1_00 on http://affix.sourceforge.net

USB support improved... Works with more devices.

Profiles supported:
- Service Discovery.
- Serial Port.
- LAN Access.
- Dialup Networking.
- OBEX Object Push.
- OBEX File Transfer.
- PAN.


GUI environment A.F.E - Affix Frontend Environment available for use.
http://affix.sourceforge.net/afe

Link can be found on Affix WEB site in *Links* section.

 

Version 1.0pre1 [24.05.2002]
- [new] Added Audio support - SCO connections. Initial version.
- [changes] openobex removed from project. *openobex* has to be downlaod 
	separately from:
	http://sourceforge.net/projects/openobex/
	or if you are Debian user just: 
	apt-get install libopenobex1
	apt-get install libopenobex-dev
- [fix/changes] USB driver modified. It reads EP addresses from the device.
	It now support some non-standard devices.
- [fix] some fixes in uart driver.
- [fix] CC in config.in can be set to properly compile by different compiler.
	(by cross compiler)


br, Dmitry 

-- 
 Dmitry Kasatkin
 Nokia Research Center / Helsinki
 Mobile: +358 50 4836365
 E-Mail: dmitry.kasatkin@nokia.com


