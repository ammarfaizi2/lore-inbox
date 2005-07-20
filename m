Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVGTKkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVGTKkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 06:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVGTKkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 06:40:21 -0400
Received: from grerelbas01.net.external.hp.com ([192.6.111.85]:46768 "EHLO
	grerelbas01.bastion.europe.hp.com") by vger.kernel.org with ESMTP
	id S261157AbVGTKkP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 06:40:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Dual-core with kernel 2.4 (Red Hat EL 3)
Date: Wed, 20 Jul 2005 12:40:11 +0200
Message-ID: <213219CA6232F94E989A9A5354135D2F09387C@frqexc04.emea.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Dual-core with kernel 2.4 (Red Hat EL 3)
Thread-Index: AcWMmAcNvssNvVqzSFexWJksgVV1BwAfuuLA
From: "Cabaniols, Sebastien" <sebastien.cabaniols@hp.com>
To: "Hubert Schwarthoff" <hubert@mail.lns.cornell.edu>,
       "linux-kernel mailing list" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Jul 2005 10:40:11.0846 (UTC) FILETIME=[67FF0E60:01C58D17]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Redhat 3 update 5 may be what you are looking for (dual core support).
Please note, this may not be the right list for these questions, the
redhat kernel is something very different from the www.kernel.org kernel
(same applies to suse/mandrake....)

Best regards

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Hubert
Schwarthoff
Sent: mardi 19 juillet 2005 21:22
To: linux-kernel mailing list
Subject: Dual-core with kernel 2.4 (Red Hat EL 3)


Hallo, Linux folks!
(first post here)
I am trying to find out whether I can start using dual-core cpus with a
2.4 kernel (Red Hat EL 3).
Three questions below - please answer if you have any insight.
 - The first update to EL 4 announced "support" for dual core cpus both
   from AMD and Intel, but doesn't say what that support means. I would
   think with the right BIOS, the OS might distribute all tasks among
   all cores right out of the box, as long as you don't need any special
   parallel computing capabilities.
   Or will the kernel just not recognize the second core?
 - The most recent update to EL 3 (which is what I am using) does not
   say anything about dual-core. Does that mean there is no chance it
   will run on a dual-core chip, because it has kernel 2.4?
 - My application is multi process server type stuff. I'd like to use
   Intel dual chip boards. Are there any Intel dual chip dual-core
   solutions you can buy? I haven't found one yet.
 Cheers
 Hubert Schwarthoff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
