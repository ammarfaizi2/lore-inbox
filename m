Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSGFRtT>; Sat, 6 Jul 2002 13:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315708AbSGFRtS>; Sat, 6 Jul 2002 13:49:18 -0400
Received: from mgw-x3.nokia.com ([131.228.20.26]:50149 "EHLO mgw-x3.nokia.com")
	by vger.kernel.org with ESMTP id <S315690AbSGFRtO>;
	Sat, 6 Jul 2002 13:49:14 -0400
Message-ID: <3D272E0D.3010707@nokia.com>
Date: Sat, 06 Jul 2002 20:51:09 +0300
From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020412 Debian/0.9.9-6
X-Accept-Language: en
MIME-Version: 1.0
Newsgroups: comp.os.linux.networking
To: affix-devel@lists.sourceforge.net,
       Affix support <affix-support@lists.sourceforge.net>
CC: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>,
       linux-net <linux-net@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: [new release] Affix-1_00pre6  --- The most powerfull Bluetooth Protocol
 Stack.
References: <3C500D09.4080206@nokia.com> <3C5AB093.5050405@nokia.com> <3C5E4991.6010707@nokia.com> <3C628D6A.2050900@nokia.com> <3C628DCF.40700@nokia.com> <3C6D25F6.4010905@nokia.com> <3C766511.5050808@nokia.com> <3C7F6C0C.6030204@nokia.com> <3C877AC7.8090008@nokia.com> <3C92111C.1070107@nokia.com> <3CA3A149.1080905@nokia.com> <3CAE2484.8090304@nokia.com> <3CB99689.7090105@nokia.com> <3CEEC240.8030905@nokia.com> <3CFF615E.50500@nokia.com> <3D0A74ED.1000902@nokia.com> <3D186CC7.4090305@nokia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jul 2002 17:51:50.0239 (UTC) FILETIME=[CE1DB6F0:01C22515]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Find new Affix release Affix-1_00pre6 on http://affix.sourceforge.net

Latest News

     * [06.07.2002] New Affix Release - Affix-1_00pre6. (see Changelog)).
     * [05.06.2002] Affix Debain packages from Mario Joussen.
	Add following lines to sources.list:
	deb http://people.debian.org/~joussen/unofficial unstable .
	deb-src http://people.debian.org/~joussen/unofficial unstable .


New features:
- iMac, iPaq tested.
- packages for iPaq -> http://affix.sourceforge.net/ipaq.shtml
- Audio suppored (in/out modes)


Version 1.0pre6 [06.07.2002]
- [new] libaffix*.so now has version
- [new] added *cleanold* rule to Makefile to remove old versions of the
	files
- [fix] OBEX server and client fixed and improved.
- [new] *put*, *get*, and *push* commands measure the transfer speed
- [new] btctl got new commands: *ping* and *sping*
	*sping* measures transfer speed in one direction
- [new] affix_usb able to send audio data to Bluetooth module
- [new] added new library *affix_utils* and some functions moved there
- [fix] some minor fixes over the code


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
  Affix Project Leader
  Mobile: +358 50 4836365
  E-Mail: dmitry.kasatkin@nokia.com

