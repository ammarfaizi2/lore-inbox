Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268210AbUG2P1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268210AbUG2P1l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268162AbUG2P1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:27:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15585 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268220AbUG2PVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 11:21:37 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16649.5485.651481.534569@segfault.boston.redhat.com>
Date: Thu, 29 Jul 2004 11:19:09 -0400
To: suparna@in.ibm.com
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, linux-osdl@osdl.org
Subject: Re: [PATCH 20/22] AIO poll
In-Reply-To: <20040702163946.GJ3450@in.ibm.com>
References: <20040702130030.GA4256@in.ibm.com>
	<20040702163946.GJ3450@in.ibm.com>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What are the barriers to getting the AIO poll support into the kernel?  I
think if we have AIO support at all, it makes sense to add this.

Thanks,

Jeff
