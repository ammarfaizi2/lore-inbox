Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751901AbWCNVtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbWCNVtb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbWCNVtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:49:31 -0500
Received: from fmr17.intel.com ([134.134.136.16]:64134 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751901AbWCNVta convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:49:30 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: Exports for hrtimer APIs
Date: Tue, 14 Mar 2006 13:48:11 -0800
Message-ID: <CBDB88BFD06F7F408399DBCF8776B3DC06A92B3B@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Exports for hrtimer APIs
Thread-Index: AcZHru1gKbdbbJ+OQYSLJbEVSnIb/QAAMNTg
From: "Stone, Joshua I" <joshua.i.stone@intel.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: "Christoph Hellwig" <hch@infradead.org>,
       "LKML" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Mar 2006 21:48:10.0376 (UTC) FILETIME=[FC902880:01C647B0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> The question is if the exports you want to add to the kernel are
> acceptable or not.
> 
> If the answer would be "no", trying to threaten with this kind of
> cheap tricks is silly since the answer to your exported wrappers
> would be the same as for the direct exports.

Sorry, I didn't mean to sound threatening...

My response was meant to address Christoph's implication that we
shouldn't be keeping SystemTap out of the kernel tree.  Due to the
nature of SystemTap, I don't see any way around this.

If it is decided that hrtimers are unacceptable for export, I'll respect
that decision.


Josh
