Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264037AbTEJLWF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 07:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264038AbTEJLWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 07:22:05 -0400
Received: from palrel10.hp.com ([156.153.255.245]:51669 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S264037AbTEJLWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 07:22:04 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16060.58322.808144.819886@napali.hpl.hp.com>
Date: Sat, 10 May 2003 04:34:42 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: qla1280 mem-mapped I/O fix
In-Reply-To: <1052566211.22636.1.camel@rth.ninka.net>
References: <200305100951.h4A9pSAD012127@napali.hpl.hp.com>
	<1052566211.22636.1.camel@rth.ninka.net>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 10 May 2003 04:30:11 -0700, "David S. Miller" <davem@redhat.com> said:

  DaveM> On Sat, 2003-05-10 at 02:51, David Mosberger wrote:
  >> With the fix in the second hunk, I don't see any reason not to turn on
  >> MEMORY_MAPPED_IO in qla1280.  It seems to work fine on my machine
  >> with this controller (ia64 Big Sur).

  DaveM> David, you absolute MAY NOT pass this:

Me?  It's the driver that's doing it! ;-)

	--david
