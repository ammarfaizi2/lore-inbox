Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTFXQqp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 12:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTFXQqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 12:46:45 -0400
Received: from fmr06.intel.com ([134.134.136.7]:33488 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261970AbTFXQqo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 12:46:44 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [ACPI] MS-6368L ACPI IRQ problem still in 2.4.21
Date: Tue, 24 Jun 2003 10:00:36 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A847E96FC5@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] MS-6368L ACPI IRQ problem still in 2.4.21
Thread-Index: AcM6FCfoBL4mgdmnSPi7UHILaLyiwgAXdfHg
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Marek Michalkiewicz" <marekm@amelek.gda.pl>,
       "Matthew Wilcox" <willy@debian.org>
Cc: <linux-kernel@vger.kernel.org>, <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 24 Jun 2003 17:00:36.0668 (UTC) FILETIME=[21F1BFC0:01C33A72]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Marek Michalkiewicz [mailto:marekm@amelek.gda.pl] 
> On Mon, Jun 23, 2003 at 11:23:11PM +0100, Matthew Wilcox wrote:
> > Have you patched 2.4.21 with the latest ACPI patch, or is 
> this vanilla
> > 2.4.21?
> 
> Vanilla 2.4.21 - tried 2.4.21-ac1 once, but it said Oops at boot time
> (something about the VIA686A sound driver - not related to ACPI).

OK then I'm pretty sure this is fixed in 2.4.22-pre1.

Regards -- Andy
