Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316978AbSFFOS5>; Thu, 6 Jun 2002 10:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316981AbSFFOS4>; Thu, 6 Jun 2002 10:18:56 -0400
Received: from ip68-9-71-221.ri.ri.cox.net ([68.9.71.221]:40028 "EHLO
	hotmale.boyland.org") by vger.kernel.org with ESMTP
	id <S316978AbSFFOSz>; Thu, 6 Jun 2002 10:18:55 -0400
Message-ID: <3CFF6F48.2020708@blue-labs.org>
Date: Thu, 06 Jun 2002 10:18:48 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0+) Gecko/20020501
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PF_UNIX bug?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Message fully processed with Bmilter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote: "btw. linux has bug with PF_UNIX dgram sockets. it is possible 
for sendto to block on such soket but select/poll _always_ indicate 
writability."

Does this bug still exist, will it be addressed?

David


