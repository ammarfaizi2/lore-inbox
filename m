Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289837AbSBOPPw>; Fri, 15 Feb 2002 10:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289834AbSBOPPn>; Fri, 15 Feb 2002 10:15:43 -0500
Received: from mgw-x2.nokia.com ([131.228.20.22]:26357 "EHLO mgw-x2.nokia.com")
	by vger.kernel.org with ESMTP id <S289837AbSBOPPd>;
	Fri, 15 Feb 2002 10:15:33 -0500
Message-ID: <3C6D25F6.4010905@nokia.com>
Date: Fri, 15 Feb 2002 17:15:02 +0200
From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011023
MIME-Version: 1.0
Newsgroups: comp.os.linux.networking
To: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
CC: affix-devel@lists.sourceforge.net,
        Affix support <affix-support@lists.sourceforge.net>,
        Bluetooth-Drivers-for-Linux 
	<Bluetooth-Drivers-for-Linux@research.nokia.com>,
        NRC-WALLET DL <DL.NRC-WALLET@nokia.com>,
        linux-net <linux-net@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: New Affix Release: Affix-0_92
In-Reply-To: <3C500D09.4080206@nokia.com> <3C5AB093.5050405@nokia.com> <3C5E4991.6010707@nokia.com> <3C628D6A.2050900@nokia.com> <3C628DCF.40700@nokia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2002 15:15:31.0199 (UTC) FILETIME=[9B8708F0:01C1B633]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Find new affix release Affix-0_92 on
http://affix.sourceforge.net

Version 0.92 [15.02.2002]
- UART protocol fixed
  setup proper uart parameters to make uart working
  example:
  stty -F /dev/ttyS0 -crtscts ispeed 57600 ospeed 57600
  btctl open_uart /dev/ttyS0

Tested with Philips Truebaby module.

br, Dmitry

-- 
 Dmitry Kasatkin
 Nokia Research Center / Helsinki
 Mobile: +358 50 4836365
 E-Mail: dmitry.kasatkin@nokia.com



