Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbUCSBed (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 20:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbUCSBed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 20:34:33 -0500
Received: from ozlabs.org ([203.10.76.45]:63366 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262002AbUCSBec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 20:34:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16474.19882.417526.420741@cargo.ozlabs.ibm.com>
Date: Fri, 19 Mar 2004 12:32:26 +1100
From: Paul Mackerras <paulus@samba.org>
To: Greg KH <greg@kroah.com>
Cc: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org
Subject: Re: whiteheat USB serial compile failure on PPC (2.6)
In-Reply-To: <20040319010015.GE19053@kroah.com>
References: <Pine.GSO.4.44.0403181205080.15185-100000@math.ut.ee>
	<20040319010015.GE19053@kroah.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:

> Bah, looks like PPC doesn't ever define CMSPAR :(

What the heck is CMSPAR?  Is it in POSIX?

Paul.
