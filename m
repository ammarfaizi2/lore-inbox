Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313279AbSC1XCn>; Thu, 28 Mar 2002 18:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313282AbSC1XCe>; Thu, 28 Mar 2002 18:02:34 -0500
Received: from mgw-x2.nokia.com ([131.228.20.22]:46245 "EHLO mgw-x2.nokia.com")
	by vger.kernel.org with ESMTP id <S313279AbSC1XCV>;
	Thu, 28 Mar 2002 18:02:21 -0500
Message-ID: <3CA3A149.1080905@nokia.com>
Date: Fri, 29 Mar 2002 01:03:37 +0200
From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020211
X-Accept-Language: en
MIME-Version: 1.0
Newsgroups: comp.os.linux.networking
To: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
CC: affix-devel@lists.sourceforge.net,
        Affix support <affix-support@lists.sourceforge.net>,
        linux-net <linux-net@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: New Affix Release: Affix-0_97  --- Bluetooth Protocol Stack. OBEX and GUI available now.
In-Reply-To: <3C500D09.4080206@nokia.com> <3C5AB093.5050405@nokia.com> <3C5E4991.6010707@nokia.com> <3C628D6A.2050900@nokia.com> <3C628DCF.40700@nokia.com> <3C6D25F6.4010905@nokia.com> <3C766511.5050808@nokia.com> <3C7F6C0C.6030204@nokia.com> <3C877AC7.8090008@nokia.com> <3C92111C.1070107@nokia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Mar 2002 23:02:11.0548 (UTC) FILETIME=[97F8F9C0:01C1D6AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All.

Find new affix release Affix-0_97 on http://affix.sourceforge.net
*with OBEX client  *

GUI environment A.F.E - Affix Frontend Environment available for use.
http://affix.sourceforge.net/afe

Link can be found on Affix WEB site in *Links* section.

Version 0.97 [28.03.2002]
- [new] added OBEX File Transfer support (ls, put, get) commands
- [new] added "browse" command to btctl for service browsing
- [new] added "search" command to btctl for service searching
            It works well with Windows Stack from DigiAnswer.
            Windows stack does not use PublicBrowseGroup
- [new] server channel for *connect* and OBEX commands is extracted from 
SDP server
            to disable this behavior use "-s" or "--nosdp" options
- [fix] OBEX server fixed. it works now.
- [new] kernel 2.4.18 fixed
- [fix] device registration/unregistration in PAN



br, Dmitry

-- 
  Dmitry Kasatkin
  Nokia Research Center / Helsinki
  Mobile: +358 50 4836365
  E-Mail: dmitry.kasatkin@nokia.com



