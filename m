Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263044AbTCLA0j>; Tue, 11 Mar 2003 19:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263042AbTCLA0i>; Tue, 11 Mar 2003 19:26:38 -0500
Received: from fmr06.intel.com ([134.134.136.7]:52939 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S263044AbTCLAXj>; Tue, 11 Mar 2003 19:23:39 -0500
Subject: [TRIVIAL]kernel-api docbook fix for now non-existant PCI hotplug
	file
From: Rusty Lynch <rusty@linux.co.intel.com>
To: trivial@rustycorp.com.au
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Mar 2003 16:28:13 -0800
Message-Id: <1047428894.8065.6.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a trivial documentation fix for some of recent PCI hotplug changes
that enables 'make htmldocs' to complete.

--- Documentation/DocBook/kernel-api.tmpl.orig	2003-03-11 16:14:25.000000000 -0800
+++ Documentation/DocBook/kernel-api.tmpl	2003-03-11 16:09:01.000000000 -0800
@@ -173,7 +173,6 @@
      </sect1>
      <sect1><title>PCI Hotplug Support Library</title>
 !Edrivers/hotplug/pci_hotplug_core.c
-!Edrivers/hotplug/pci_hotplug_util.c
      </sect1>
      <sect1><title>MCA Architecture</title>
 	<sect2><title>MCA Device Functions</title>



