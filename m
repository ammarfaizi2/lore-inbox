Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313661AbSDEWZB>; Fri, 5 Apr 2002 17:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313659AbSDEWYw>; Fri, 5 Apr 2002 17:24:52 -0500
Received: from mgw-x1.nokia.com ([131.228.20.21]:14069 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id <S313658AbSDEWYq>;
	Fri, 5 Apr 2002 17:24:46 -0500
Message-ID: <3CAE2484.8090304@nokia.com>
Date: Sat, 06 Apr 2002 01:26:12 +0300
From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020211
X-Accept-Language: en
MIME-Version: 1.0
Newsgroups: comp.os.linux.networking
To: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
CC: affix-devel@lists.sourceforge.net,
        Affix support <affix-support@lists.sourceforge.net>,
        linux-net <linux-net@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: New Affix Release: Affix-0_98  --- Bluetooth Protocol Stack. OBEX and GUI available now.
In-Reply-To: <3C500D09.4080206@nokia.com> <3C5AB093.5050405@nokia.com> <3C5E4991.6010707@nokia.com> <3C628D6A.2050900@nokia.com> <3C628DCF.40700@nokia.com> <3C6D25F6.4010905@nokia.com> <3C766511.5050808@nokia.com> <3C7F6C0C.6030204@nokia.com> <3C877AC7.8090008@nokia.com> <3C92111C.1070107@nokia.com> <3CA3A149.1080905@nokia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Apr 2002 22:24:43.0712 (UTC) FILETIME=[AF766C00:01C1DCF0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All.

Find new affix release Affix-0_98 on http://affix.sourceforge.net
*with OBEX client  *

Now it's possible to send pictures to the Mobile Phone.

GUI environment A.F.E - Affix Frontend Environment available for use.
http://affix.sourceforge.net/afe

Link can be found on Affix WEB site in *Links* section.


Version 0.98 [05.04.2002]
- [new] added *push* command for pushing objects.
	E.g. I pushed background pictures for Ericsson T68 phone 
	(picture should be in GIF format for Ericsson phone).
	btctl push 00:80:37:ee:38:9f test1.gif
- [fix] added service type to connect to to *btctl connect* command
	btctl connect <bda> SERial|LAN|DUP
	check *btctl -h*
- [fix] SDP service search and attribute request can be done on the same
	L2CAP connection
- [fix] some OBEX fixes


br, Dmitry

