Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAKLg0>; Thu, 11 Jan 2001 06:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129610AbRAKLgQ>; Thu, 11 Jan 2001 06:36:16 -0500
Received: from ns1.netbauds.net ([194.207.240.11]:5389 "EHLO ns1.netbauds.net")
	by vger.kernel.org with ESMTP id <S129324AbRAKLgI>;
	Thu, 11 Jan 2001 06:36:08 -0500
Message-ID: <3A5D9A82.2568646B@netbauds.net>
Date: Thu, 11 Jan 2001 11:35:30 +0000
From: Darryl Miles <darryl@netbauds.net>
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 2.4.0: Small observation in /proc/sys/net/unix/
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# ls -il /proc/sys/net/unix/
total 24
   4446 -rw-------   1 root     root            0 Jan 11 11:06
max_dgram_qlen
   4446 -rw-------   1 root     root            0 Jan 11 11:06
max_dgram_qlen

Identical filenames, nothing bad appears to be happening it just looks
weird.

-- 
Darryl Miles
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
