Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266608AbUBDWEM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 17:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUBDWEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 17:04:12 -0500
Received: from imap.gmx.net ([213.165.64.20]:57263 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266600AbUBDWEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 17:04:00 -0500
X-Authenticated: #532004
Subject: questin about switch off
From: Roman Jordan <RomanJordan@gmx.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1075932364.2952.112.camel@darkstar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Feb 2004 23:06:04 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
i use a sony laptop with kernel 2.6.1 and acpi support. If i want do
switch it off the device, using the command 'halt' or 'poweroff' the
laptop does not switch off. I only get the message 'system haltet'. If
use the kernel without ACPI, the display is drawing black, but the
device is also not swiched off.
If i using the fedora standard kernel 2.4.22-1.2115.nptl the 'halt'
command works fine.
Any ideas?

Regards,
Roman Jordan

