Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbUBRJ4y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 04:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbUBRJ4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 04:56:54 -0500
Received: from aun.it.uu.se ([130.238.12.36]:14018 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263486AbUBRJ4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 04:56:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16435.14044.182718.134404@alkaid.it.uu.se>
Date: Wed, 18 Feb 2004 10:56:44 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel vs AMD x86-64
In-Reply-To: <Pine.LNX.4.58.0402171739020.2686@home.osdl.org>
References: <Pine.LNX.4.58.0402171739020.2686@home.osdl.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
 > 
 > Ok, 
 >  now that Intel has finally come clean about their x86-64 implementation
 > (see
 > 
 > 	http://www.intel.com/technology/64bitextensions/index.htm?iid=techtrends+spotlight_64bit
 > 
 > for full details), can somebody write up a list of differences? I know
 > there are people who have had access to the Intel docs for a while now,
 > and obviously Intel is too frigging proud to list the differences
 > explicitly.

>From what I can see from these docs, Intel's "IA-32e" is very very close
to the natural combination of P4 with AMD64. No hyperlink stuff, but
otherwise the same. The local APIC and performance counters should be
exactly as in P4 :-)

What about naming? IA-64 is taken, AMD64 is too specific, Intel's
"IA-32e" sounds too vague, and I find x86-64 / x86_64 difficult to type.
"x64" perhaps?
