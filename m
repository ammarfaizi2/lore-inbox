Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263507AbUCTSv6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 13:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263508AbUCTSv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 13:51:57 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:58634 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263507AbUCTSvz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 13:51:55 -0500
Date: Sat, 20 Mar 2004 19:52:09 +0100
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] barrier patch set
Message-ID: <20040320185209.GB2016@hh.idb.hist.no>
References: <20040319153554.GC2933@suse.de> <405B2127.8090705@pobox.com> <20040319230136.GC7161@merlin.emma.line.org> <200403200102.39716.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403200102.39716.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 01:02:39AM +0100, Bartlomiej Zolnierkiewicz wrote:
[...]
> There were reports that on some drives you can't disable write cache
> and even (?) that some drives lie (WC still enabled but marked as disabled).
> 
I think the simple solution of not supporting data integrity properly
on such a broken disk is perfectly ok.

Helge Hafting

