Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbWJBRjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbWJBRjr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbWJBRjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:39:46 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:36554 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S965164AbWJBRjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:39:45 -0400
Date: Mon, 2 Oct 2006 14:39:39 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Removes duplicated entry
Message-ID: <20061002143939.1fd40527@doriath.conectiva>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The 'STABLE BRANCH' entry is duplicated, removes it.

Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
---
 MAINTAINERS |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f0cd5a3..b62ab43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2711,14 +2711,6 @@ M:	chrisw@sous-sol.org
 L:	stable@kernel.org
 S:	Maintained
 
-STABLE BRANCH:
-P:	Greg Kroah-Hartman
-M:	greg@kroah.com
-P:	Chris Wright
-M:	chrisw@sous-sol.org
-L:	stable@kernel.org
-S:	Maintained
-
 TPM DEVICE DRIVER
 P:	Kylene Hall
 M:	kjhall@us.ibm.com
-- 
1.4.2



-- 
Luiz Fernando N. Capitulino
