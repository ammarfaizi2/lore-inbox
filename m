Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315459AbSFYNQv>; Tue, 25 Jun 2002 09:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315463AbSFYNQu>; Tue, 25 Jun 2002 09:16:50 -0400
Received: from mgw-x1.nokia.com ([131.228.20.21]:4065 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id <S315459AbSFYNQt>;
	Tue, 25 Jun 2002 09:16:49 -0400
Message-ID: <3D186CC7.4090305@nokia.com>
Date: Tue, 25 Jun 2002 16:14:47 +0300
From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020412 Debian/0.9.9-6
MIME-Version: 1.0
Newsgroups: comp.os.linux.networking
To: affix-devel@lists.sourceforge.net,
       Affix support <affix-support@lists.sourceforge.net>
CC: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>,
       linux-net <linux-net@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: [new release - stable] Affix-1_00pre5  --- The most powerfull Bluetooth
 Protocol Stack.
References: <3C500D09.4080206@nokia.com> <3C5AB093.5050405@nokia.com> <3C5E4991.6010707@nokia.com> <3C628D6A.2050900@nokia.com> <3C628DCF.40700@nokia.com> <3C6D25F6.4010905@nokia.com> <3C766511.5050808@nokia.com> <3C7F6C0C.6030204@nokia.com> <3C877AC7.8090008@nokia.com> <3C92111C.1070107@nokia.com> <3CA3A149.1080905@nokia.com> <3CAE2484.8090304@nokia.com> <3CB99689.7090105@nokia.com> <3CEEC240.8030905@nokia.com> <3CFF615E.50500@nokia.com> <3D0A74ED.1000902@nokia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jun 2002 13:16:49.0397 (UTC) FILETIME=[904DCA50:01C21C4A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Find new Affix release Affix-1_00pre5 on http://affix.sourceforge.net
This is stable version. See News Section.

New features:
- iMac, iPaq tested.
- obex fixed.
- packages for iPaq -> http://affix.sourceforge.net/ipaq.shtml


Version 1.0pre5 [24.06.2002]
- [new] *open_uart* enhanced to support vendor dependend initialization
	btctl open_uart <vendor> <speed> <flags>
- [fix] minor rfcomm fixes.
- [fix] btobex fixed. It was not working after in *pre3/4* because of 
one bug
- [fix] btctl inquiry cache finaly fixed.
- [fix] SDP fixed to correctly work on ARM/SPARC/PPC architectures
- [changes] SDP file structure changed. Header files moved to affix
	client need to include sdp.h, sdpclt.h and sdpsrv.h
- [changes] user space apps. shall use only <affix/btcore.h>
do not use <affix/hci.h>



  Affix works on platforms (tested):
- i386.
- ARM (e.g. Compaq iPac).
- PowerPC (e.g. iMac).

Affix currently supports the following Bluetooth Profiles:
- General Access Profie
- Service Discovery Profile
- Serial Port Profile
- DialUp Networking Profile
- LAN Access Profile
- OBEX Object Push Profile
- OBEX File Transfer Profile
- PAN Profile


GUI environment A.F.E - Affix Frontend Environment available for use.
http://affix.sourceforge.net/afe

Link can be found on Affix WEB site in *Links* section.

br, Dmitry

-- 
  Dmitry Kasatkin
  Nokia Research Center / Helsinki
  *Affix* Project Coordinator (http://affix.sourceforge.net)
  Mobile: +358 50 4836365
  E-Mail: dmitry.kasatkin@nokia.com

