Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbUAOXUZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 18:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265128AbUAOXUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 18:20:25 -0500
Received: from aun.it.uu.se ([130.238.12.36]:28602 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263898AbUAOXUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 18:20:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16391.8241.423590.961211@alkaid.it.uu.se>
Date: Fri, 16 Jan 2004 00:20:17 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Jim Garrison <garrison@case.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 compile error - drivers/block/swim3.c (powerpc)
In-Reply-To: <1074205253.636.11.camel@ibook>
References: <1074205253.636.11.camel@ibook>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Garrison writes:
 > Hello,
 > 
 > I know that gcc 3.3.2 is not an officially supported compiler, but this
 > error seems to be of the generic kind.  swim3.c fails to compile for me
 > on powerpc.

This is a known problem which has been going on for quite a while.
Search the LKML archives for info and pointers to fixes, or use
Ben's powermac kernel tree.
