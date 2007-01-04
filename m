Return-Path: <linux-kernel-owner+w=401wt.eu-S965031AbXADQdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbXADQdI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbXADQdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:33:08 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:64102 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965031AbXADQdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:33:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=HWdE097+90ofj+b9LfULT71/+FRbOEPsQ5ZUhlIx0VbuAvCaZ0gYoHL2PEIOZ66Jb6j+LxQyrAmE6VgVYt/S0koiTO5W0ff0QiXPGd1EpsQMPkZtpmJY1ka8dchy0CounlL/MJBIz7qUEnMo47gsAdq4rBYRnCGACXkWXxG6MSM=
Date: Thu, 4 Jan 2007 19:33:04 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pata_optidma: typo in Kconfig
Message-ID: <20070104163303.GA5169@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/ata/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -381,7 +381,7 @@ config PATA_OPTI
 	  If unsure, say N.
 
 config PATA_OPTIDMA
-	tristate "OPTI FireStar PATA support (Veyr Experimental)"
+	tristate "OPTI FireStar PATA support (Very Experimental)"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables DMA/PIO support for the later OPTi

