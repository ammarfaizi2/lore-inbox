Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbTIOVbP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 17:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbTIOVbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 17:31:15 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:23310 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S261631AbTIOVbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 17:31:12 -0400
Date: Mon, 15 Sep 2003 18:33:53 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
cc: "Brown, Len" <len.brown@intel.com>,
       Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: ACPI fixes
Message-ID: <Pine.LNX.4.44.0309151824360.2914-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Len, 

What about merging this patches in linux-acpi.bkbits.com ?

They seem to be in the ACPI tree for some time now.

ASUS A7V BIOS version 1011 from  blacklist (Eric Valette)
support non ACPI compliant SCI over-ride  specs (Jun Nakajima)
Fix ACPI oops on ThinkPad T32/T40 (Shaohua 
Extended IRQ resource type for nForce (Andrew 
Handle BIOS with _CRS that fails (Jun Nakajima)

Andrew, your fallback to PIC mode patch seems to be doing well, right? 

Did you try to get it into the ACPI tree?  



