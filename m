Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbUKEAsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbUKEAsp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 19:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbUKEAsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 19:48:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:30942 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261457AbUKEAsn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:48:43 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] More Driver Core patches for 2.6.10-rc1
In-Reply-To: <10996157052061@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 4 Nov 2004 16:48:26 -0800
Message-Id: <10996157064167@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2449.2.11, 2004/11/04 12:00:36-08:00, rml@novell.com

[PATCH] kobject_uevent: add MAINTAINER entry

Attached patch adds a MAINTAINER entry for the kernel event layer.


Signed-Off-By: Robert Love <rml@novell.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+)


diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	2004-11-04 16:30:02 -08:00
+++ b/MAINTAINERS	2004-11-04 16:30:02 -08:00
@@ -1247,6 +1247,12 @@
 W:	http://www.cse.unsw.edu.au/~neilb/patches/linux-devel/
 S:	Maintained
 
+KERNEL EVENT LAYER (KOBJECT_UEVENT)
+P:	Robert Love
+M:	rml@novell.com
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 LANMEDIA WAN CARD DRIVER
 P:	Andrew Stanley-Jones
 M:	asj@lanmedia.com

