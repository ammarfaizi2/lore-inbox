Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268725AbTBZR3t>; Wed, 26 Feb 2003 12:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268745AbTBZR3t>; Wed, 26 Feb 2003 12:29:49 -0500
Received: from fmr02.intel.com ([192.55.52.25]:45525 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S268725AbTBZR3t>; Wed, 26 Feb 2003 12:29:49 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A8471380CF@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
Subject: RE: /proc/cpuinfo shows only 2 processors on dual P4-Xeon system
Date: Wed, 26 Feb 2003 09:39:39 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andrew Walrond [mailto:andrew@walrond.org] 
> ...with latest 2.5.63+ bk kernel. Is this correct?
> 
> 2.4 kernel shows 4 processors.

Enable the ACPI "CPU enumeration only" option.

Regards -- Andy
