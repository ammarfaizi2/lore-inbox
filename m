Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264154AbUFVONZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbUFVONZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 10:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbUFVOFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 10:05:09 -0400
Received: from aun.it.uu.se ([130.238.12.36]:54750 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263786AbUFVN7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 09:59:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16600.15183.989137.233305@alkaid.it.uu.se>
Date: Tue, 22 Jun 2004 15:59:43 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Andrew Morton <akpm@osdl.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
In-Reply-To: <20040622015311.561a73bf.akpm@osdl.org>
References: <200405312218.i4VMIISg012277@harpo.it.uu.se>
	<20040622015311.561a73bf.akpm@osdl.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Mikael Pettersson <mikpe@csd.uu.se> wrote:
 > >
 > > perfctr-2.7.3 for 2.6.7-rc1-mm1, part 1/6:
 > >
 > 
 > OK, I spent a couple hours on the perfctr code.  It looks sane, although a
 > bit hard to follow.  The above changelog (which is _all_ you gave us) makes
 > this large and complex patch hard to review, hard to understand, hard for
 > others to support.
 > 
 > One can look at the code, sort-of-see what it's doing, query micro-issues,
 > but it is hard (and a bad use of one's time) to try and reverse-engineer
 > the big-picture "how it all hangs together" from the implementation.
 > 
 > We need (especially at this stage in the kernel cycle) at least a couple of
 > pages of design documentation which describes

Speaking of documentation, I have a strong preference for using
LaTeX for all papers, reports, docs, etc, except man pages.
Is that an acceptable format?
