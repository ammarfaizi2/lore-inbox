Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbUBZWTH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbUBZWTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:19:07 -0500
Received: from mail010.syd.optusnet.com.au ([211.29.132.56]:54224 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261170AbUBZWTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:19:04 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16446.28626.290987.585867@wombat.chubb.wattle.id.au>
Date: Fri, 27 Feb 2004 09:14:42 +1100
To: Kingsley Cheung <kingsley@aurema.com>
Cc: Andrew Morton <akpm@osdl.org>, davidm@hpl.hp.com, davidm@napali.hpl.hp.com,
       peter@chubb.wattle.id.au, linux-kernel@vger.kernel.org,
       Daniel Jacobowitz <dan@debian.org>
Subject: Re: /proc visibility patch breaks GDB, etc.
In-Reply-To: <20040227085941.A21764@aurema.com>
References: <16445.37304.155370.819929@wombat.chubb.wattle.id.au>
	<20040225224410.3eb21312.akpm@osdl.org>
	<16446.19305.637880.99704@napali.hpl.hp.com>
	<20040226120959.35b284ff.akpm@osdl.org>
	<20040227085941.A21764@aurema.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Kingsley" == Kingsley Cheung <kingsley@aurema.com> writes:

Kingsley> On Thu, Feb 26, 2004 at 12:09:59PM -0800, Andrew Morton
Kingsley> wrote:

Kingsley> The patch that broke backwards compatibility for GDB
Kingsley> likewise changed that.  It enforces that tid must be a part
Kingsley> of the pid thread group.

For what it's worth, the patch also breaks JVM 1.4re2.

Peter C
