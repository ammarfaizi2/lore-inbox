Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130485AbRDCIXk>; Tue, 3 Apr 2001 04:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131587AbRDCIXa>; Tue, 3 Apr 2001 04:23:30 -0400
Received: from albireo.ucw.cz ([62.168.0.14]:260 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id <S130485AbRDCIXY>;
	Tue, 3 Apr 2001 04:23:24 -0400
Date: Tue, 3 Apr 2001 10:22:04 +0200
From: Martin Mares <mj@suse.cz>
To: Tim Hockin <thockin@isunix.it.ilstu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 66MHz PCI
Message-ID: <20010403102204.A363@albireo.ucw.cz>
In-Reply-To: <200104030731.CAA07050@isunix.it.ilstu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104030731.CAA07050@isunix.it.ilstu.edu>; from thockin@isunix.it.ilstu.edu on Tue, Apr 03, 2001 at 02:31:40AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> is it possible to detect whether a device is running at 66MHz (as opposed
> to 33)?  PCI defines a 66MHz capable bit, but not a 66MHz enabled bit.  We
> have a silly device that seems to need to know what it's bus speed is, but
> have no way to tell from software (that I know of).
> 
> So, pray tell -- is there a way to figure it out?

There is, but unfortunately it's host bridge specific.

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
If a train station is where the train stops, what is a work station?
