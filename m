Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131695AbRAJJMp>; Wed, 10 Jan 2001 04:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131936AbRAJJMf>; Wed, 10 Jan 2001 04:12:35 -0500
Received: from c017-h014.c017.sfo.cp.net ([209.228.12.228]:40868 "HELO
	c017.sfo.cp.net") by vger.kernel.org with SMTP id <S131695AbRAJJMc>;
	Wed, 10 Jan 2001 04:12:32 -0500
X-Sent: 10 Jan 2001 09:12:24 GMT
Message-ID: <3A5C2811.8010708@SANgate.com>
Date: Wed, 10 Jan 2001 11:14:57 +0200
From: Ben-Hanokh Gabriel <gabriel@SANgate.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; 0.6) Gecko/20001205
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: using kernel_thread() from kernel space ???
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

where can i find documanation about  programming with kernel_thread in 
kernel-space ?

i saw that kernel_thread() and daemonize() kernel-calls are used by khttpd,
  is there a usage documantion about them ?
  what about other calls ?

please CC me for any comment

THX
/gabriel



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
