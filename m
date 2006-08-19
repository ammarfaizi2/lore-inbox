Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWHSEGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWHSEGE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 00:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWHSEGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 00:06:03 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:49793 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932365AbWHSEGB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 00:06:01 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
Message-ID: <17638.36427.377725.693294@tut.ibm.com>
Date: Fri, 18 Aug 2006 23:06:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: "Bjo Breiskoll" <bjo@nefkom.net>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
       zanussi@us.ibm.com
Subject: Re: Relay-Subsystem
In-Reply-To: <20060818171857.6cd7e6c0.rdunlap@xenotime.net>
References: <000501c6c321$58d1a830$03b2a8c0@bjoserver>
	<20060818171857.6cd7e6c0.rdunlap@xenotime.net>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap writes:
 > On Sat, 19 Aug 2006 01:52:21 +0200 Bjo Breiskoll wrote:
 > 
 > > Is there an updated description about the new relay-subsystem
 > > available? The old relayfs.h is gone and you made quite a few
 > > changes. The whole examples-tarball from
 > > http://sourceforge.net/projects/relayfs wont work. (And i need
 > > blocking-relayfile IO.) :-)
 > 
 > When I updated Documentation/filesystems/relayfs.txt recently,
 > Jens advised me that it needs lots of work.  I was hoping that
 > Tom Zanussi would get around to doing that.
 > For a current working example, see block/blktrace.c.

I had started on this then got sidetracked - in any case I'll post
up-to-date documentation along with an updated examples-tarball in the
next day or two.  Sorry for any inconvenience...

Tom


