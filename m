Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129697AbQKMOC3>; Mon, 13 Nov 2000 09:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129881AbQKMOCU>; Mon, 13 Nov 2000 09:02:20 -0500
Received: from astrid2.nic.fr ([192.134.4.2]:24076 "EHLO astrid2.nic.fr")
	by vger.kernel.org with ESMTP id <S129697AbQKMOCK>;
	Mon, 13 Nov 2000 09:02:10 -0500
Date: Mon, 13 Nov 2000 15:02:15 +0000
From: Francois romieu <romieu@ensta.fr>
To: linux-kernel@vger.kernel.org
Cc: Mircea Damian <dmircea@linux.kappa.ro>
Subject: [upatch] Documentation/Configure.help (was: ppp.txt)
Message-ID: <20001113150215.C12459@nic.fr>
Reply-To: Francois romieu <romieu@ensta.fr>
In-Reply-To: <20001112180007.A5323@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001112180007.A5323@linux.kappa.ro>; from dmircea@linux.kappa.ro on Sun, Nov 12, 2000 at 06:00:07PM +0200
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Sun, Nov 12, 2000 at 06:00:07PM +0200, Mircea Damian wrote :
[...]
> I just want to say that the file 'Documentation/networking/ppp.txt' (as it
> is mentioned in Configure.help at CONFIG_PPP option) does not exists.

--- /usr/src/linux-2.4.0-test11-pre4.orig/Documentation/Configure.help	Mon Nov 13 09:55:53 2000
+++ /usr/src/linux-2.4.0-test11-pre4/Documentation/Configure.help	Mon Nov 13 14:57:25 2000
@@ -6795,10 +6795,9 @@
   days support PPP rather than SLIP.
 
   To use PPP, you need an additional program called pppd as described
-  in Documentation/networking/ppp.txt and in the PPP-HOWTO, available
-  at http://www.linuxdoc.org/docs.html#howto . If you upgrade
-  from an older kernel, you might need to upgrade pppd as well. The
-  PPP option enlarges your kernel by about 16 KB.
+  in the PPP-HOWTO, available at http://www.linuxdoc.org/docs.html#howto. 
+  If you upgrade from an older kernel, you might need to upgrade pppd as 
+  well. The PPP option enlarges your kernel by about 16 KB.
 
   There are actually two versions of PPP: the traditional PPP for
   asynchronous lines, such as regular analog phone lines, and

-- 
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
