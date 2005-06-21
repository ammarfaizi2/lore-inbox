Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVFUPWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVFUPWm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbVFUPWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:22:39 -0400
Received: from web8409.mail.in.yahoo.com ([202.43.219.157]:20321 "HELO
	web8409.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S262119AbVFUPVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:21:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=q7CQZDCkADE0+rWOhyo3Amqw496xyWVH6f8GTFR2Ga1y+q9zCQfVnrTC2/3PQ2aHFDjIUyAk7WaX3EFx7qgQN/GQ7wTLIs0/pdGjq8rXgu1aSRznB3b08BY6Grc0OAE+i17qXQBvP4uLVv+FJD7WimBQahnmwsmHy+Xcuf3obKM=  ;
Message-ID: <20050621152133.77162.qmail@web8409.mail.in.yahoo.com>
Date: Tue, 21 Jun 2005 16:21:33 +0100 (BST)
From: KV Pavuram <kvpavuram@yahoo.co.in>
Subject: 0xffffe002 in ??
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running a multithreaded application on Linux 2.4
kernel (RedHat Linux 9).

At some point the program receives a seg. fault and if
i check info threads, using gdb for debug, almost all
the threads are at "0xffffe002 in ??" 

When I switch to each of these tasks, and try x/i for
0xffffe002, cannot access address.

What could be the problem?

Please help.

Regards,
Pav.


		
__________________________________________________________
How much free photo storage do you get? Store your friends 'n family snaps for FREE with Yahoo! Photos http://in.photos.yahoo.com
