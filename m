Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbVAZXLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVAZXLM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVAZXK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:10:56 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:24019 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262432AbVAZRIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 12:08:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=eBWru/NxoONJUeWSPB7rfmoRjj03nk/fGEu6zmqyUcZMQEtlvsYjp/gd7ZugzNTaByhqFEQim7ratqOxZ2pPu+ugiWfUa3B327AA1LRb/EjuOo1bvFkWERP4WNvSYB4fd8l8zcYI1LR0aiL0IsE8sERNIm16oR0WsbFPB44z2ME=
Message-ID: <41F7C080.8090204@gmail.com>
Date: Wed, 26 Jan 2005 17:08:32 +0100
From: Mikkel Krautz <krautz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: greg@kroah.com, roms@lpg.ticalc.org, jb@technologeek.org
Subject: [PATCH 2/3] TIGLUSB Cleanups
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the TIGLUSB-maintainers from hte MAINTAINERS-file.


Signed-off-by: Mikkel Krautz <krautz@gmail.com>
---

 MAINTAINERS |    7 -------
 1 files changed, 7 deletions(-)

--- clean/MAINTAINERS
+++ dirty/MAINTAINERS
@@ -2178,13 +2178,6 @@
 M:    hch@infradead.org
 S:    Maintained
 
-TI GRAPH LINK USB (SilverLink) CABLE DRIVER
-P:    Romain Lievin
-M:    roms@lpg.ticalc.org
-P:    Julien Blache
-M:    jb@technologeek.org
-S:    Maintained
-
 TI PARALLEL LINK CABLE DRIVER
 P:     Romain Lievin
 M:     roms@lpg.ticalc.org

