Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbWIFXMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbWIFXMg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965283AbWIFXM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:12:26 -0400
Received: from web30314.mail.mud.yahoo.com ([209.191.69.76]:10159 "HELO
	web30314.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965039AbWIFXCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:02:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ckD5UzK3kNgi15JVCtjF02HDVDqzMRocPgOl8bqDKfzERDyYcB01KSPyZFVJBPHnLBvzM0xhvlokJS0PZtjkPulmfXIx+BHmklOWkfeBbVSiGhLLXXO9dFwRgdlqX/RcnzZSgYMrM+1BgOUPd13ZAJvgh6kqjllh6UxCnaqOjOM=  ;
Message-ID: <20060906230245.68889.qmail@web30314.mail.mud.yahoo.com>
Date: Wed, 6 Sep 2006 16:02:45 -0700 (PDT)
From: "Gary C. New" <garycnew@yahoo.com>
Subject: modprobe: modprobe: Can't locate module eth
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently upgraded my kernel to linux-2.4.33.2. 
Everything seems to have compiled and installed
correctly, except for a few modprobe messages at
bootup.

modprobe: modprobe: Can't locate module eth5
modprobe: modprobe: Can't locate module eth6
modprobe: modprobe: Can't locate module eth7
modprobe: modprobe: Can't locate module eth8
modprobe: modprobe: Can't locate module eth9

It appears that both my eth0 and eth1 interfaces are
loaded with the appropriate drives and work correctly,
but for some reason modprobe gives the above messages.

Thank you for your kind assistance.

Respectfully,


Gary
