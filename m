Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbTEFW4Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 18:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbTEFWyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 18:54:16 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:1198 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262041AbTEFWwp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 18:52:45 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10522624131454@kroah.com>
Subject: Re: [PATCH] PCI hotplug changes for 2.5.69
In-Reply-To: <10522624131038@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 6 May 2003 16:06:53 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.889.392.3, 2003/03/19 15:45:39-08:00, rusty@linux.co.intel.com

[PATCH] PCI Hotplug: kernel-api docbook fix for now non-existant PCI hotplug

Here is a trivial documentation fix for some of recent PCI hotplug changes
that enables 'make htmldocs' to complete.


 Documentation/DocBook/kernel-api.tmpl |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/Documentation/DocBook/kernel-api.tmpl b/Documentation/DocBook/kernel-api.tmpl
--- a/Documentation/DocBook/kernel-api.tmpl	Tue May  6 15:56:11 2003
+++ b/Documentation/DocBook/kernel-api.tmpl	Tue May  6 15:56:11 2003
@@ -173,7 +173,6 @@
      </sect1>
      <sect1><title>PCI Hotplug Support Library</title>
 !Edrivers/hotplug/pci_hotplug_core.c
-!Edrivers/hotplug/pci_hotplug_util.c
      </sect1>
      <sect1><title>MCA Architecture</title>
 	<sect2><title>MCA Device Functions</title>

