Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263096AbTJJWus (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 18:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263141AbTJJWus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 18:50:48 -0400
Received: from palrel13.hp.com ([156.153.255.238]:27599 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263096AbTJJWur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 18:50:47 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16263.14277.278807.472247@napali.hpl.hp.com>
Date: Fri, 10 Oct 2003 15:50:45 -0700
To: jbarnes@sgi.com (Jesse Barnes)
Cc: Patrick Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org,
       davidm@napali.hpl.hp.com
Subject: Re: [PATCH] Altix I/O code cleanup
In-Reply-To: <20031010215153.GA5328@sgi.com>
References: <3F872984.7877D382@sgi.com>
	<20031010215153.GA5328@sgi.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 10 Oct 2003 14:51:53 -0700, jbarnes@sgi.com (Jesse Barnes) said:

  Jesse> David, please apply this set of patches from Pat.

Unfortunately, the 2.6 tree is closed for cleanups.  I would _like_ to
see the patch applied, though.  Perhaps you could talk to Andrew and
see if you can get an exception?

  Jesse> Btw, any estimate as to when your BK tree will be updated?

Just did a short while ago.  It's not the final stuff, but getting closer.
(I just merged your discontig fixes, btw.)

	--david
