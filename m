Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbVAZXNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVAZXNi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVAZXNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:13:07 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:37875 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262443AbVAZR0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 12:26:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type;
        b=P5E/MhB1GoYUhzCVR8E1IOTA9eUhgwkS6RbSLeAQYiHYEVfTe1AFf6daZ0i4kxxR+KDagDk3KgH7WEwPHBXOb33q+QaFuF/TX4kzcfJN6s+x4I51G41d2XSth+D9173F5KjKNNlK2RQF9u1ShP9J0+B7s/pBFqEDvuoynnnXHgI=
Message-ID: <41F7D2CB.50802@gmail.com>
Date: Wed, 26 Jan 2005 18:26:35 +0100
From: Mikkel Krautz <krautz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: greg@kroah.com, roms@lpg.ticalc.org, jb@technologeek.org
Subject: [PATCH 2/3] TIGLUSB Cleanups
Content-Type: multipart/mixed;
 boundary="------------030402040804060208090109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030402040804060208090109
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This removes the TIGLUSB-maintainers from the MAINTAINERS-file.

--------------030402040804060208090109
Content-Type: text/x-patch;
 name="remove_silverlink_maintainers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="remove_silverlink_maintainers.patch"

Signed-off-by: Mikkel Krautz <krautz@gmail.com>
---

 MAINTAINERS |    7 -------
 1 files changed, 7 deletions(-)

--- clean/MAINTAINERS
+++ dirty/MAINTAINERS
@@ -2178,13 +2178,6 @@
 M:	hch@infradead.org
 S:	Maintained
 
-TI GRAPH LINK USB (SilverLink) CABLE DRIVER
-P:	Romain Lievin
-M:	roms@lpg.ticalc.org
-P:	Julien Blache
-M:	jb@technologeek.org
-S:	Maintained
-
 TI PARALLEL LINK CABLE DRIVER
 P:     Romain Lievin
 M:     roms@lpg.ticalc.org

--------------030402040804060208090109--
