Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265923AbUBCIUN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 03:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265936AbUBCIUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 03:20:12 -0500
Received: from mx.sz.bfs.de ([194.94.69.70]:60558 "EHLO mx.sz.bfs.de")
	by vger.kernel.org with ESMTP id S265923AbUBCIUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 03:20:09 -0500
Date: Tue, 3 Feb 2004 9:20:10 +0100
Illegal-Object: Syntax error in Message-ID: value found on vger.kernel.org:
	Message-ID:	=?ISO-8859-1?Q?=20<vines.sxdD+tap=B5?= =?ISO-8859-1?Q?+A@SZKOM.BFS.DE>
				^		  ^-illegal end of message identification
			 \-Extraneous program text, illegal start of message identification
X-Priority: 3 (Normal)
To: <saw@saw.sw.com.sg>
Cc: <linux-kernel@vger.kernel.org>
From: <WHarms@bfs.de> (Walter Harms)
Reply-To: <WHarms@bfs.de>
Subject: inux-2.6.1 eepro100: wait_for_cmd_done timeout!
X-Incognito-SN: 25185
X-Incognito-Version: 5.1.0.84
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
X-Amavis-Alert: BAD HEADER Non-encoded 8-bit data (char B5 hex) in message header 'Message-ID'
  Message-ID: <vines.sxdD+tap\265+A@SZKOM.BFS.DE>\n
                             ^
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <S265923AbUBCIUN/20040203082013Z+179@vger.kernel.org>

hi,
google showd me that this is problem since linux 2.2
i run a linux 2.6.1 om my ACER tm620 and the driver by Donald Becker.

My build-in card gets the timeout and after:
 transmit timed out: status 0050 0cf0 at xxxxx/xxx command 000c0000 it works again (for some time)

The eepro100 is compiled in.

should i spend time to find more infos ?

regards,
walter

