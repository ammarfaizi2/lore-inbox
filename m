Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVDMOD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVDMOD6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 10:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVDMOD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 10:03:58 -0400
Received: from [193.112.238.6] ([193.112.238.6]:40322 "EHLO caveman.xisl.com")
	by vger.kernel.org with ESMTP id S261342AbVDMODz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 10:03:55 -0400
Subject: Re: Exploit in 2.6 kernels
From: John M Collins <jmc@xisl.com>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Lars Marowsky-Bree <lmb@suse.de>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050413132308.GP17865@csclub.uwaterloo.ca>
References: <1113298455.16274.72.camel@caveman.xisl.com>
	 <425BBDF9.9020903@ev-en.org> <1113318034.3105.46.camel@caveman.xisl.com>
	 <20050412210857.GT11199@shell0.pdx.osdl.net>
	 <1113341579.3105.63.camel@caveman.xisl.com>
	 <425CEAC2.1050306@aitel.hist.no>
	 <20050413125921.GN17865@csclub.uwaterloo.ca>
	 <20050413130646.GF32354@marowsky-bree.de>
	 <20050413132308.GP17865@csclub.uwaterloo.ca>
Content-Type: text/plain
Organization: Xi Software Ltd
Date: Wed, 13 Apr 2005 15:01:46 +0100
Message-Id: <1113400906.10763.20.camel@caveman.xisl.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-13 at 09:23 -0400, Lennart Sorensen wrote:

> Graphics card companies don't realize they are hardware companies not
> software companies and that it is hardware they make their money from?
> Oh and they have too many lawyers?
> 
> It seems to me that 2D graphics are a done deal, with no new inovation
> taking place.  Releasing programing specs for that part should be a no
> brainer.  If the nifty 3D routines are so important to keep secret from
> the other guys then well keep those.  Release the 2D programing specs!

Where I am (in the UK) you more or less have to buy computers in bits
and put them together if you want (like I do) to shuffle bits of
hardware between different machines to suit varying needs or bolt on
extra bits and pieces of new hardware and above all not pay M$ tax.

The nvidia card seems the only one with reasonable performance at a
reasonable price that fits on most motherboards that I can find.in these
parts.

> m-a is module-assistant which is used on debian to build a module

If I ask nicely can I download it from anywhere? I've just finished
building 2.6.11.7 and it might be nice to try it.

Could I possibly make a suggestion for "make xconfig" in the kernel tree
(and make other-kinds-of-config I suppose)?

I currently routinely copy the ".config" out of the previous kernel tree
before I start to save working through questions about sound cards I
never heard of and so forth.

Could it perhaps optionally initialise most of the settings to fit the
current machine and/or grab the last lot of settings
from /proc/config.gz?


John Collins Xi Software Ltd www.xisl.com Tel: +44 (0)1707 886110
(Direct) +44 (0)7799 113162 (Mobile)

