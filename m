Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbTEKW2K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 18:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbTEKW2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 18:28:10 -0400
Received: from customer-148-223-196-18.uninet.net.mx ([148.223.196.18]:45447
	"EHLO soltisns.soltis.cc") by vger.kernel.org with ESMTP
	id S261365AbTEKW2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 18:28:08 -0400
From: "jds" <jds@soltis.cc>
To: linux-kernel@vger.kernel.org
Subject: 2.5.69mm3 ACPI problem, not problem pci=noacpi
Date: Sun, 11 May 2003 16:03:55 -0600
Message-Id: <20030511215920.M95815@soltis.cc>
X-Mailer: Open WebMail 1.90 20030212
X-OriginatingIP: 200.78.44.117 (jds)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



   Hi:


   Im have other problems with ACPI, when boot normal ACPI the PCMCIA cardbus
not working, the messages is "Device busy".

    When boot with parameter in kernel line   "pci=noacpi" the working good
PCMCIA cardbus and network.

    Maybe the problems is IRQs shared with ACPI in PCI.


    Helpme plase 
    Regards



