Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268140AbRHQFhu>; Fri, 17 Aug 2001 01:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269712AbRHQFhk>; Fri, 17 Aug 2001 01:37:40 -0400
Received: from sv1.ramix.jp ([210.169.188.193]:47876 "HELO mail.ramix.jp")
	by vger.kernel.org with SMTP id <S268140AbRHQFhe>;
	Fri, 17 Aug 2001 01:37:34 -0400
Date: Fri, 17 Aug 2001 14:37:41 +0900
From: YOSHIMURA Keitaro <ramsy@linux.or.jp>
To: Alan.Cox@linux.org, torvalds@transmeta.com
Subject: our japanese transtations documents.
Cc: linux-kernel@vger.kernel.org, jf@linux.or.jp
Message-Id: <20010817143326.D809.RAMSY@linux.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.07
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Alan and Linus,

Could you consider adding a pointer to our Japanese translation of the
kernel documents somewhere in the the doc subdirectory of the kernel
source tree? We volunteers have translated most of the docs in the
Documentation subdirectory of Linux-2.2.x and 2.4.x in the JF project. 
We now believe our translation will be of great help for Japanese
Linux users and, perhaps, adding a link to our website in the index
file of the doc directory would be appropriate. Two tentative patches
are included below for the two versions of the kernel to make all the
changes needed. Thank you in advance.

Best Regards,

=====
--- linux-2.2.19/Documentation/00-INDEX    Fri Aug 10 21:52:30 2001
+++ linux-2.2.19.N/Documentation/00-INDEX        Fri Aug 10 21:59:49 2001
@@ -5,6 +5,11 @@
 keep the descriptions small enough to fit on one line.
 							 Thanks -- Paul G.

+Following translations are available on the WWW:
+
+   - Japanese, maintained by the JF Project (JF@linux.or.jp), at
+     http://www.linux.or.jp/JF/
+
 00-INDEX
        - this file.
 ARM-README
=====
--- linux-2.4.9/Documentation/00-INDEX-2.4.7	Fri Feb  9 09:32:44 2001
+++ linux-2.4.9.N/Documentation/00-INDEX-2.4.7-new	Fri Aug 10 22:12:38 2001
@@ -5,6 +5,11 @@
 Please try and keep the descriptions small enough to fit on one line.
 							 Thanks -- Paul G.
 
+Following translations are available on the WWW:
+
+   - Japanese, maintained by the JF Project (JF@linux.or.jp), at
+     http://www.linux.or.jp/JF/
+
 00-INDEX
 	- this file.
 BUG-HUNTING
=====

<|> YOSHIMURA 'ramsy' Keitaro / JF Project
<|> mailto:ramsy@linux.or.jp
<|> http://www.linux.or.jp/JF/

