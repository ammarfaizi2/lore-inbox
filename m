Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751838AbWFWS1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbWFWS1x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbWFWS1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:27:53 -0400
Received: from mail.visionpro.com ([63.91.95.13]:24023 "EHLO
	chicken.machinevisionproducts.com") by vger.kernel.org with ESMTP
	id S1751838AbWFWS1w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:27:52 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: [PATCH] mm: tracking shared dirty pages -v10
Date: Fri, 23 Jun 2006 11:27:51 -0700
Message-ID: <14CFC56C96D8554AA0B8969DB825FEA0012B3592@chicken.machinevisionproducts.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mm: tracking shared dirty pages -v10
Thread-Index: AcaW8ljmRwGDmCWFSUaYULinD/6t8AAAC+rA
From: "Brian D. McGrew" <brian@visionpro.com>
To: "Linus Torvalds" <torvalds@osdl.org>, "Martin Bligh" <mbligh@google.com>
Cc: "Christoph Lameter" <clameter@sgi.com>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Hugh Dickins" <hugh@veritas.com>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "David Howells" <dhowells@redhat.com>,
       "Christoph Lameter" <christoph@lameter.com>,
       "Nick Piggin" <npiggin@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I had assumed this was a sick joke. Please tell me people aren't
> really swapping over NFS. That's *insane*.

Hey, I think it even used to be common. I think some NCR X client did 
basically exactly that, with _no_ local disk at all.

			Linus

---

Some of us still do!  Ah, the joys of remote clients!!!
(Now that I think about it, I should put those guys back on dial-up)

:b!
