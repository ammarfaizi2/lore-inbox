Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWCDRBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWCDRBg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 12:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbWCDRBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 12:01:36 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:45575 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751483AbWCDRBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 12:01:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=TwW6leXFz3xynlJ+gVyJiPXE7m+lZ2ORO/Y+u5X7hpVB4+RhmU3rjq2q4eK66jP8ZI9xkVonN+oU4XrsoxGFgMztnIcZ4CtzlCYkhMEMLqCpnOqIKK5EnwBu+dO0pLclvNMd8kkvVG5Z9mTEAq/rCFtdNAdmC0Zrv4ldtQwCF5A=
Date: Sat, 4 Mar 2006 20:01:30 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: =?iso-8859-1?Q?H=E5kon_L=F8vdal?= <Hakon.Lovdal@ericsson.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] README: bzip2 is not new
Message-ID: <20060304170130.GA22058@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Håkon Løvdal <Hakon.Lovdal@ericsson.com>

Signed-off-by: Håkon Løvdal <Hakon.Lovdal@ericsson.com>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

--- a/README
+++ b/README
@@ -74,7 +74,7 @@ INSTALLING the kernel:
    whatever the kernel-du-jour happens to be.
 
  - You can also upgrade between 2.6.xx releases by patching.  Patches are
-   distributed in the traditional gzip and the new bzip2 format.  To
+   distributed in the traditional gzip and the newer bzip2 format.  To
    install by patching, get all the newer patch files, enter the
    top level directory of the kernel source (linux-2.6.xx) and execute:
 

