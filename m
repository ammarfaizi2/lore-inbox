Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267458AbTAXAAK>; Thu, 23 Jan 2003 19:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267463AbTAXAAK>; Thu, 23 Jan 2003 19:00:10 -0500
Received: from fmr01.intel.com ([192.55.52.18]:8187 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267458AbTAXAAJ>;
	Thu, 23 Jan 2003 19:00:09 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A847137FB5@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org, acpi-devel@sourceforge.net
Subject: RE: [PATCH] ACPI update (20030122)
Date: Thu, 23 Jan 2003 16:09:07 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dave Jones [mailto:davej@codemonkey.org.uk] 
> I've noticed that with .59 some of my boxes no longer have
> functioning NICs unless I boot with acpi=off. Packets get
> transmitted, but nothing ever gets received.
> Seen this with a 3c509, an 8139, and an e100.
> 
> Known bug? Fixed in this patch ?

Known bug. Not fixed in this patch. Are you sure this is new in recent
kernels?

Regards -- Andy
