Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270119AbTGNNbG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 09:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270089AbTGNNa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 09:30:26 -0400
Received: from fmr05.intel.com ([134.134.136.6]:65002 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S265182AbTGNN2p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 09:28:45 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [Patch] 1/4 PCI Hot-plug driver patch for 2.5.74 kernel
Date: Mon, 14 Jul 2003 06:43:31 -0700
Message-ID: <42050DF556283A4D977B111EB7063208100277@orsmsx407.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch] 1/4 PCI Hot-plug driver patch for 2.5.74 kernel
Thread-Index: AcNJ0QT/zJvTafr8SI+bQ6p5FYIhDAAO9M9w
From: "Sy, Dely L" <dely.l.sy@intel.com>
To: "Greg KH" <greg@kroah.com>, "Dely Sy" <dlsy@unix-os.sc.intel.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Jul 2003 13:43:32.0064 (UTC) FILETIME=[EA315E00:01C34A0D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This patch was sent out to this and pcihpd-discuss mailing lists on
> > 7/10.  However, it didn't show up on this mailing list most probably
> > due to the message size.  Now I make it into 4 parts and resend them.
> > There were already a few discussions on this patch.

> Hm, this just split the patch up along file diffs?  Did you change
> anything from the one big patch you send me earlier?

Yes, this is just a re-send of the original big patch to the lkml for it
can't take message more than 100KB.  The original message didn't show up
in lkml after I sent it.  For this one, I just split it up along file 
diffs.

I'll look into the feasibility of splitting up the patch into smaller
ones according to functionality as suggested by you and Dan after I get 
back from vacation on 7/21.  

Thanks,
Dely
