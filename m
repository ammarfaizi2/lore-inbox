Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbTIEWW6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 18:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbTIEWW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 18:22:58 -0400
Received: from fmr09.intel.com ([192.52.57.35]:467 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S265248AbTIEWWz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 18:22:55 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [UPDATED PATCH] EFI support for ia32 kernels
Date: Fri, 5 Sep 2003 15:22:50 -0700
Message-ID: <0448350A99F69145AEACC4B950ECB3260455FE7A@fmsmsx406.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [UPDATED PATCH] EFI support for ia32 kernels
Thread-Index: AcNz9HMn02tF4P9ZSHK2/DjZBAD3zQABDF5g
From: "Doran, Mark" <mark.doran@intel.com>
To: "Jamie Lokier" <jamie@shareable.org>
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Andrew Morton" <akpm@osdl.org>,
       "Matt Tolentino" <metolent@snoqualmie.dp.intel.com>,
       <linux-kernel@vger.kernel.org>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
X-OriginalArrivalTime: 05 Sep 2003 22:22:50.0993 (UTC) FILETIME=[3E415E10:01C373FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, September 05, 2003 2:24 PM Jamie Lokier wrote:

> EFI is covered by patents?  What are they?

Actually no, there are no patents that I'm aware of that read on EFI.
We made a point of not filing any on the spec.  We told everyone we
talked to during the spec's development that we wouldn't file any so
that the spec would end up free of any IP considerations when
complete.  This was a deliberate effort to support the goal of
minimizing any potential barriers to adoption of EFI as much as
possible.

The patent license grant is thus in some sense a double coverage
approach...you don't really need a patent license grant since there
aren't any patents that read but to reinforce that you don't need to
worry about patents we give you the grant anyway.  This helped make
some corporate entities more comfortable about implementing support
for EFI.

In practice we have required that any feedback or contribution to the
EFI spec or code from third parties that is given to us also comes
without any IP encumbrances.  There are a couple of things that I've
been offered that I would like to have included but couldn't in the
end because it would not have been possible to continue telling folks
using the EFI spec that they can do so without concern for IP issues.

Cheers,

Mark.

