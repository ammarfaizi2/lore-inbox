Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312025AbSCQNyl>; Sun, 17 Mar 2002 08:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312033AbSCQNyc>; Sun, 17 Mar 2002 08:54:32 -0500
Received: from kura.mail.jippii.net ([195.197.172.113]:38022 "HELO
	kura.mail.jippii.net") by vger.kernel.org with SMTP
	id <S312025AbSCQNyZ>; Sun, 17 Mar 2002 08:54:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: jarmo kettunen <oh1mrr@nic.fi>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.19-pre3-ac1
Date: Sun, 17 Mar 2002 15:55:05 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020317135423.F2F6C1FCC5@kura.mail.jippii.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just patched 2.4.18 first into 2.4.19-pre3 and direct into 2.4.19-pre3-ac1.
Couldn't get compile through because of error /linux/drivers/md/md.c.

Looked and found patch for 2.5.6 series kernel and used it...Now compile
succeeded.

I'm not sure if bug is in pre3 or pre3-ac1,but I'm sure it's not in 2.4.18,I 
got that compiled without any errors.

So just wanted to notify...

Jarmo
