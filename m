Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbTKKCuA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 21:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbTKKCuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 21:50:00 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:62897 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263304AbTKKCt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 21:49:59 -0500
From: "Joseph Shamash" <info@avistor.com>
To: "Peter Chubb" <peter@chubb.wattle.id.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 2 TB partition support
Date: Mon, 10 Nov 2003 18:52:14 -0800
Message-ID: <HBEHKOEIIJKNLNAMLGAOMEDBDKAA.info@avistor.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <16304.19406.995702.451479@wombat.chubb.wattle.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I've only created a 2.4.20 patch;...

I seem to remember there was a bug for the 2.4.20 kernel. IIRC, it had
something to do with unmounting a filesystem and losing data, if the data
was still in the cache. Is this true? Can I find a patch for this, if it is
true?

Thanks



-----Original Message-----
From: Peter Chubb [mailto:peterc@chubb.wattle.id.au]On Behalf Of Peter
Chubb
Sent: Monday, November 10, 2003 6:39 PM
To: Joseph Shamash
Cc: Peter Chubb; linux-kernel@vger.kernel.org
Subject: RE: 2 TB partition support


>>>>> "Joseph" == Joseph Shamash <info@avistor.com> writes:

Joseph> Hello Peter, Forgive another quick Q or two.

Joseph> What is the maximum partition size for a patched 2.4.x kernel,
Joseph> and where are those patches?

See http://www.gelato.unsw.edu.au/IA64wiki/LargeBlockDevices

I've only created a 2.4.20 patch; on my TODO list for the next
fortnight is to create a 2.4.23 patch, as we move towards a 2.4.23
release.

Petre C



