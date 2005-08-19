Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932689AbVHSSi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbVHSSi4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 14:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbVHSSi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 14:38:56 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:8663 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932689AbVHSSiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 14:38:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=S4jDleDC6zOx/bMZefBel7lRw4xU7bdaAY18m9dcKxAD79Ldfhpueqyu0/EZbuRkM0XpHCzzYcpcrC+Xzlx+xiEQeFwJExeZ5YWi1xT2TOFJQRr5zShjelvyg07RYQJlpvTLaV2Npqd8spJl6sNUUdeJD72/C5D7Cnn9VKE6plo=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] add `applying-patches.txt' to Documentation/00-INDEX
Date: Fri, 19 Aug 2005 20:39:31 +0200
User-Agent: KMail/1.8.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       Paul Gortmaker <p_gortmaker@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508192039.31624.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

When I sent the patch to add the new documentation 
file `applying-patches.txt', I forgot to add it to 
00-INDEX as well. This patch corrects that oversight.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Documentation/00-INDEX |    2 ++
 1 files changed, 2 insertions(+)

--- linux-2.6.13-rc6-mm1-orig/Documentation/00-INDEX	2005-08-19 19:20:58.000000000 +0200
+++ linux-2.6.13-rc6-mm1/Documentation/00-INDEX	2005-08-19 20:31:00.000000000 +0200
@@ -46,6 +46,8 @@
 	- procedure to get a source patch included into the kernel tree.
 VGA-softcursor.txt
 	- how to change your VGA cursor from a blinking underscore.
+applying-patches.txt
+	- description of various trees and how to apply their patches.
 arm/
 	- directory with info about Linux on the ARM architecture.
 basic_profiling.txt


