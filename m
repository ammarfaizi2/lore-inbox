Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293574AbSCGOer>; Thu, 7 Mar 2002 09:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293515AbSCGOe3>; Thu, 7 Mar 2002 09:34:29 -0500
Received: from mgw-x1.nokia.com ([131.228.20.21]:30869 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id <S292955AbSCGOeW>;
	Thu, 7 Mar 2002 09:34:22 -0500
Message-ID: <3C877AC7.8090008@nokia.com>
Date: Thu, 07 Mar 2002 16:35:51 +0200
From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011023
MIME-Version: 1.0
Newsgroups: comp.os.linux.networking
To: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
CC: affix-devel@lists.sourceforge.net,
        Affix support <affix-support@lists.sourceforge.net>,
        linux-net <linux-net@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: New Affix Release: Affix-0_95  --- Bluetooth Protocol Stack
In-Reply-To: <3C500D09.4080206@nokia.com> <3C5AB093.5050405@nokia.com> <3C5E4991.6010707@nokia.com> <3C628D6A.2050900@nokia.com> <3C628DCF.40700@nokia.com> <3C6D25F6.4010905@nokia.com> <3C766511.5050808@nokia.com> <3C7F6C0C.6030204@nokia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2002 14:34:19.0147 (UTC) FILETIME=[2A54D5B0:01C1C5E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All.


Find new affix release Affix-0_94 on
http://affix.sourceforge.net

Version 0.95 [07.03.2002]
- [fix] changes in /etc/pcmcia/config file
	device "affix_uart" to device "affix_uart_cs"
	bind "affix_uart" to bind "affix_uart_cs"
	PCMCIA does not work correctly in previouse case
- [new] btctl prints features suported by the module (Audio,...)
- [fix] SDP stuff has been fixed to be compiled with C compiler
- [fix] extra locks added to l2cap and rfcomm modules
- [fix] module counters fixed



br, Dmitry

-- 
 Dmitry Kasatkin
 Nokia Research Center / Helsinki
 Mobile: +358 50 4836365
 E-Mail: dmitry.kasatkin@nokia.com



