Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTK1Mwf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 07:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbTK1Mwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 07:52:35 -0500
Received: from mail.skjellin.no ([80.239.42.67]:35763 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S262188AbTK1Mwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 07:52:34 -0500
Subject: Re: oops on P4 i875 w/ 2 gig RAM [2.4 stuff]
From: Andre Tomt <lkml@tomt.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Magnus Stenman <stone@hkust.se>
In-Reply-To: <3FC72D71.9090708@hkust.se>
References: <3FC1EE97.7020302@hkust.se>  <3FC72D71.9090708@hkust.se>
Content-Type: text/plain
Message-Id: <1070023938.29985.35.camel@slurv.pasop.tomt.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 28 Nov 2003 13:52:19 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-11-28 at 12:11, Magnus Stenman wrote:
> nobody has any clues?
> 
> you know, there *is* a juicy kernel BUG in there

Looks like you use a Red Hat kernel, it's heavily patched, and has thus
its own set of problems. You're probably better off bugging Red Hat
instead.

