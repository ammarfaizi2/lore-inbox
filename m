Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbUDOA6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 20:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbUDOA6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 20:58:08 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:12752 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S262448AbUDOA6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 20:58:05 -0400
Message-ID: <407DDE4C.7060701@oracle.com>
Date: Thu, 15 Apr 2004 02:58:52 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040323
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.5-bk[12] break Cisco VPN client
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Module loading complains in 2.6.5-bk1 and bk2 with an
  "Invalid module format" error message.

2.6.5 loads the Cisco VPN module ok.

Tried upgrading my old module-init-tools to 3.0, still no go.
Tried patching Makefile with Sam Ravnborg's latest kbuild fix,
  still no go.

Currently loaded the Cisco VPN module built under 2.6.5 into
  a 2.6.5-bk2 kernel; this works.


Please CC: me on replies since I'm not on the list... thanks
  in advance ! Ciao,

--alessandro

  "Don't grow up too fast and don't embrace the past
   This life's too good to last"
       (Muse, "Blackout")

