Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbTAIFGD>; Thu, 9 Jan 2003 00:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbTAIFGC>; Thu, 9 Jan 2003 00:06:02 -0500
Received: from fmr02.intel.com ([192.55.52.25]:25556 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261599AbTAIFGC>; Thu, 9 Jan 2003 00:06:02 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84725A110@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Dominik Brodowski <linux@brodo.de>
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk,
       acpi-devel@lists.sourceforge.net
Subject: RE: [PATCH 2.5.54] cpufreq-ACPI: deprecated usage of CPUFREQ_ALL_
	CPUS
Date: Wed, 8 Jan 2003 17:06:15 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dominik Brodowski [mailto:linux@brodo.de] 
> Deprecated usage of CPUFREQ_ALL_CPUS: as policy->cpu now only points
> to an existing CPU, some code can safely be removed from the ACPI
> P-States cpufreq driver.

OK thanks, applied.

BTW Dominik in the future don't feel you need to submit cpufreq-ACPI
patches through me - although a CC would still be nice. ;-)

Regards -- Andy
