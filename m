Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWAJKdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWAJKdD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 05:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWAJKdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 05:33:01 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:27606
	"EHLO pcpool00.mathematik.uni-freiburg.de") by vger.kernel.org
	with ESMTP id S1750854AbWAJKdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 05:33:01 -0500
Date: Tue, 10 Jan 2006 11:32:59 +0100
From: "Bernhard R. Link" <brl@pcpool00.mathematik.uni-freiburg.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Olivier Galibert <galibert@pobox.com>
Subject: File type by extension is evil (was Re: Why the DOS has many ntfs read and write driver,but the linux can't for a long time)
Message-ID: <20060110103259.GA9285@pcpool00.mathematik.uni-freiburg.de>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	Olivier Galibert <galibert@pobox.com>
References: <5t06S-7nB-15@gated-at.bofh.it> <1136824149.5785.75.camel@tara.firmix.at> <1136824880.9957.55.camel@mindpipe> <200601091753.36485.oliver@neukum.org> <20060109171411.GB67773@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109171411.GB67773@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Olivier Galibert <galibert@pobox.com> [060109 19:44]:
> >From what I can see it does icons on non-executable entirely based on
> the extension and nothing else on the first pass.
> 
> Not a bad strategy, too.  Doing a file(1) on everything can only be
> slow given the random disk accesses it generates.  Maybe a file(1) as
> a _second_ pass would work.

That may be a good strategy if you have user conditioned to all the
effects you get by this (i.e. if you only focus on Windows users and
want them provide with a system as broken as they know it) and programs
adopted to cope with the most ill effects (ever asked why some browsers
always foozle the name of downloaded files with some .html or the like?)

For everyone else looking at the file is the only sane way to know the type
of file.

	Bernhard R. Link
