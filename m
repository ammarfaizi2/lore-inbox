Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316309AbSHXOE5>; Sat, 24 Aug 2002 10:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316322AbSHXOE5>; Sat, 24 Aug 2002 10:04:57 -0400
Received: from ip29.xiotech.com ([209.46.118.29]:33807 "EHLO
	pdamail.xiotech.com") by vger.kernel.org with ESMTP
	id <S316309AbSHXOE4>; Sat, 24 Aug 2002 10:04:56 -0400
Message-ID: <ED8EDD517E0AA84FA2C36C8D6D205C1303F1C304@alfred.xiotech.com>
From: "Brueggeman, Steve" <steve_brueggeman@xiotech.com>
To: "'Grover, Andrew'" <andrew.grover@intel.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Anyone know how to get soft-power-down to work on an Intel SC
	 B2??
Date: Sat, 24 Aug 2002 09:09:04 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to mention, I compiled a version of linux-2.4.9-34 with
ACPI and APM enabled, and tarballed the kernel and modules, and
installed them on several intel machines.  They all successfully
did the soft-power-off, includeing a Dell Precission 610, which
is a dual-processor system.

Steve Brueggeman
