Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbTKHPEf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 10:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTKHPEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 10:04:35 -0500
Received: from 30.Red-80-36-33.pooles.rima-tde.net ([80.36.33.30]:26585 "EHLO
	linalco.com") by vger.kernel.org with ESMTP id S261782AbTKHPEe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 10:04:34 -0500
Date: Sat, 8 Nov 2003 16:06:54 +0100
From: Ragnar Hojland Espinosa <ragnar@linalco.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Bill Davidsen <davidsen@tmr.com>, John Bradford <john@grabjohn.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Message-ID: <20031108150654.GA19980@linalco.com>
References: <Pine.LNX.3.96.1031107090309.20991B-100000@gatekeeper.tmr.com> <Pine.LNX.4.44.0311070652080.1842-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311070652080.1842-100000@home.osdl.org>
X-Edited-With-Muttmode: muttmail.sl - 2001-09-27
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 07, 2003 at 07:01:22AM -0800, Linus Torvalds wrote:
> In other words, they seem to "exist" in the same sense that soubdblaster 
> CD-ROM users "exist". True in theory, but apparently only really useful 
> for theoretical arguments.

Well, I hope its in better state than the Mitsumi driver, because last
time I tried it was broken (oopsed in a simple cat) since a 2.3.xx
IIRC [0]

[0]  Tracked it down to a -pre if anyone is interested and its still
     broken.. 
-- 
Ragnar Hojland - Project Manager
Linalco "Specialists in Linux and Free Software"
http://www.linalco.com  Tel: +34-91-4561700
