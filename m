Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263864AbUECSsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263864AbUECSsj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 14:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbUECSsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 14:48:39 -0400
Received: from fmr02.intel.com ([192.55.52.25]:7131 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S263869AbUECSsd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 14:48:33 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Open POSIX Test Suite 1.4.1 release
Date: Mon, 3 May 2004 11:48:29 -0700
Message-ID: <3A0061D7D277B5489DCBBA264884D61E89D1C1@orsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Open POSIX Test Suite 1.4.1 release
Thread-Index: AcQxPzo8B/biWEr9S/u+/96V5LuqrA==
From: "Selbak, Rolla N" <rolla.n.selbak@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 May 2004 18:48:30.0681 (UTC) FILETIME=[3A773C90:01C4313F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.4.1 of the Open POSIX Test Suite is now available at
http://posixtest.sourceforge.net 

POSIX Test Suite 1.4.1 includes more pthread conformance test cases. It
now also contains test cases covering almost all pthread APIs.
Conformance test cases for options like CPT, TCT, TMR added as well. Bug
fixes made from the previous 1.3.0 version (thanks for Ulrich Drepper's
patches and to everyone who made contributions).

This release has been tested on glibc-2004-04-29 cvs pull (NPTL enabled)
and linux-2.6.5-mm6 kernel.  It is noted that "POSIX Message Queues" has
been integrated into linux kernel and glibc. 

Please see http://posixtest.sf.net for the latest downloads, test
results and more information.

Thanks,
Rolla Selbak
http://posixtest.sf.net [POSIX Test Suite project]
	

* my views are not necessarily my employer's *

