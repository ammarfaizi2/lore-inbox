Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272149AbTHDS3D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 14:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272147AbTHDS3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 14:29:03 -0400
Received: from palrel10.hp.com ([156.153.255.245]:64423 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S272143AbTHDS14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 14:27:56 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16174.42409.306836.375697@napali.hpl.hp.com>
Date: Mon, 4 Aug 2003 11:27:53 -0700
To: jbarnes@sgi.com (Jesse Barnes)
Cc: "H. J. Lu" <hjl@lucon.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: milstone reached: ia64 linux builds out of Linus' tree
In-Reply-To: <20030804180015.GA543@sgi.com>
References: <200308041737.h74HbdCf015443@napali.hpl.hp.com>
	<20030804175308.GB16804@lucon.org>
	<20030804180015.GA543@sgi.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 4 Aug 2003 11:00:16 -0700, jbarnes@sgi.com (Jesse Barnes) said:

  Jesse> big sur is broken because non-ACPI based PCI enumeration has
  Jesse> been removed from the tree.

That shouldn't break big sur.  Perhaps you need newer firmware,
though?

	--david
