Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272941AbTHEWkV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 18:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272944AbTHEWkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 18:40:20 -0400
Received: from bozo.vmware.com ([65.113.40.130]:47622 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S272941AbTHEWkP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 18:40:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [2.6] Perl weirdness with ext3 and HTREE
Date: Tue, 5 Aug 2003 15:40:10 -0700
Message-ID: <68F326C497FDB743B5F844B776C9B146097DCD@pa-exch4.vmware.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6] Perl weirdness with ext3 and HTREE
Thread-Index: AcNbng5b7zs5S3d0Q9eF0lDNGHlSFAABDCbg
From: "Christopher Li" <chrisl@vmware.com>
To: <azarah@gentoo.org>
Cc: "KML" <linux-kernel@vger.kernel.org>, <akpm@digeo.com>,
       <adilger@clusterfs.com>, <ext3-users@redhat.com>,
       <x86-kernel@gentoo.org>
X-OriginalArrivalTime: 05 Aug 2003 22:40:10.0891 (UTC) FILETIME=[8746F5B0:01C35BA2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Martin Schlemmer [mailto:azarah@gentoo.org]
> Sent: Tuesday, August 05, 2003 3:08 PM
> To: Christopher Li
> Cc: KML; akpm@digeo.com; adilger@clusterfs.com; ext3-users@redhat.com;
> x86-kernel@gentoo.org
> Subject: RE: [2.6] Perl weirdness with ext3 and HTREE

> Yep, did that.  I had a simple c program once that tried to
> simulate all file operations on that file, and the 'real'

It is all the file operations on that *directory* that matters.
Touch a single file is unlikely make htree split.

> man page that gets installed.  Did not have the same effect
> however.  Might be that I was off by something.  Don't have
> it however anymore, as it was some months before, just before
> I mailed the first time.
> 

Chris 


