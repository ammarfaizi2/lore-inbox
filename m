Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316972AbSFABVW>; Fri, 31 May 2002 21:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316670AbSFABVV>; Fri, 31 May 2002 21:21:21 -0400
Received: from mgw-x1.nokia.com ([131.228.20.21]:40649 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id <S316666AbSFABVU>;
	Fri, 31 May 2002 21:21:20 -0400
Message-ID: <3CF8217D.1090903@nokia.com>
Date: Sat, 01 Jun 2002 04:21:01 +0300
From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020412 Debian/0.9.9-6
X-Accept-Language: en
MIME-Version: 1.0
Newsgroups: comp.os.linux.networking
To: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
CC: affix-devel@lists.sourceforge.net,
        Affix support <affix-support@lists.sourceforge.net>,
        linux-net <linux-net@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: [new release] Affix-1_00pre2  --- Bluetooth Protocol Stack. + new
 drivers for Anycom and 3COM
In-Reply-To: <3C500D09.4080206@nokia.com> <3C5AB093.5050405@nokia.com> <3C5E4991.6010707@nokia.com> <3C628D6A.2050900@nokia.com> <3C628DCF.40700@nokia.com> <3C6D25F6.4010905@nokia.com> <3C766511.5050808@nokia.com> <3C7F6C0C.6030204@nokia.com> <3C877AC7.8090008@nokia.com> <3C92111C.1070107@nokia.com> <3CA3A149.1080905@nokia.com> <3CAE2484.8090304@nokia.com> <3CB99689.7090105@nokia.com> <3CEEC240.8030905@nokia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Jun 2002 01:21:19.0335 (UTC) FILETIME=[A2142F70:01C2090A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Find new Affix release Affix-1_00pre2 on http://affix.sourceforge.net
It has improved UART, USB and extra drivers.
Anycom cards supported

Version 1.0pre2 [31.05.2002]
- [new] new drivers for *bluecard* cards (Anycom) and 3COM cards
- [new] cross-compiling support (ARM, PowerPC,...)
- [new] *open_uart* accept speed (no need to call stty)
- [fix] affix_uart support Xircom cards
- [changes] libbt*.so libs moved to libaffix*.so
- [fix] now can be compiled on kernels <= 2.4.6


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

br, Dmitry
+358 50 4836365



