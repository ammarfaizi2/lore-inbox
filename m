Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282168AbRKWRXH>; Fri, 23 Nov 2001 12:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282178AbRKWRW4>; Fri, 23 Nov 2001 12:22:56 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:54467 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S282168AbRKWRWq>; Fri, 23 Nov 2001 12:22:46 -0500
Message-ID: <3BFE8559.1040403@antefacto.com>
Date: Fri, 23 Nov 2001 17:20:25 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] remove trailing whitespace
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This (23MB! (5Mb compressed)) patch removes trailing whitespace from
all files in the kernel, thereby reducing size from 121,865,495 to
121,640,841. I.E. reducing size by 224,654 bytes. I don't know if it's
of any use, but it should be applied now if it is going to be done
at all.

http://www.iol.ie/~padraiga/linux-2.5.0-strip-ws.diff.gz

cheers,
Padraig.

