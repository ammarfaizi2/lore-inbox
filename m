Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261834AbTCaTP1>; Mon, 31 Mar 2003 14:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261835AbTCaTP1>; Mon, 31 Mar 2003 14:15:27 -0500
Received: from fmr02.intel.com ([192.55.52.25]:255 "EHLO caduceus.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261834AbTCaTPZ>;
	Mon, 31 Mar 2003 14:15:25 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A847E96D93@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Warren Turkal <wturkal@cbu.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] laptop keyboard, tracked to ACPI
Date: Mon, 31 Mar 2003 10:09:55 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Warren Turkal [mailto:wturkal@cbu.edu] 
> Andy Grover, ACPI Maintainer, I am CCing you directly as I 
> think this is your 
> bug at this point. When I compile a kernel without ACPI, the 
> bug does not 
> show its face. When I compile with ACPI in modules and load 
> none of the 
> modules, the bug still happens. I think that the bug exists 
> in the base ACPI 
> support code as a result. The bug is described below. I have 
> not tried the 
> latest linus bk patches. This current round of tests was 
> performed on 2.5.66. 
> 2.5.63 is the last version of the kernel that does not have this bug.

Please try the ACPI patch from http://sf.net/projects/acpi and let me
know if it doesn't fix things.

Thanks -- Regards -- Andy
