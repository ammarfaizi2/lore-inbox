Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270364AbTGNLig (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 07:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270371AbTGNLig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 07:38:36 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:38366 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S270364AbTGNLif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 07:38:35 -0400
Date: Mon, 14 Jul 2003 12:53:13 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Linux v2.6.0-test1
Message-ID: <20030714115313.GA21773@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	John Bradford <john@grabjohn.com>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <200307141150.h6EBoe1P000738@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307141150.h6EBoe1P000738@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 12:50:40PM +0100, John Bradford wrote:
 > > Then you'll just have to wait a few months
 > 
 > Oh well, it just seems strange to be asking people to test
 > 2.6.0-root-my-box, without making the consequences a bit clearer.

>From http://www.codemonkey.org.uk/post-halloween-2.5.txt

------ 8< 8< 8< 8< ------
Security concerns.
~~~~~~~~~~~~~~~~~~
Several security issues solved in 2.4 may not yet be forward ported
to 2.5. For this reason 2.5.x kernels should not be tested on
untrusted systems.  Testing known 2.4 exploits and reporting results
is useful.
------ 8< 8< 8< 8< ------


If you don't have the time/energy to trawl linux-kernel, testing the
many zillions of `sploits out there to see what works and what doesn't
may be more fun. (Although most if not all should be failing, so it
may also get boring very quickly). It'd be nice if someone like osdl
could add such testing to nightly regression tests. Some of them may
even be candidates for LTP perhaps ?

		Dave

