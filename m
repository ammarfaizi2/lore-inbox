Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUCVLPc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 06:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbUCVLPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 06:15:32 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:4780 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261880AbUCVLPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 06:15:31 -0500
Date: Mon, 22 Mar 2004 12:15:26 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Matthias Andree <matthias.andree@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] barrier patch set
Message-ID: <20040322111526.GB9299@merlin.emma.line.org>
Mail-Followup-To: Helge Hafting <helgehaf@aitel.hist.no>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040319153554.GC2933@suse.de> <405B2127.8090705@pobox.com> <20040319230136.GC7161@merlin.emma.line.org> <200403200102.39716.bzolnier@elka.pw.edu.pl> <20040320185209.GB2016@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320185209.GB2016@hh.idb.hist.no>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Mar 2004, Helge Hafting wrote:

> On Sat, Mar 20, 2004 at 01:02:39AM +0100, Bartlomiej Zolnierkiewicz wrote:
> [...]
> > There were reports that on some drives you can't disable write cache
> > and even (?) that some drives lie (WC still enabled but marked as disabled).
> > 
> I think the simple solution of not supporting data integrity properly
> on such a broken disk is perfectly ok.

At least Linux should warn the user that his data is heading for doom.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
