Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWIWGNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWIWGNr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 02:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWIWGNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 02:13:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:8624 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751109AbWIWGNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 02:13:47 -0400
Subject: Re: [PATCH] radeonfb supend/resume support for Acer Aspire 2010
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suspend-devel list <suspend-devel@lists.sourceforge.net>,
       "Benjamin A. Okopnik" <ben@linuxgazette.net>
In-Reply-To: <45144343.7080404@gmx.net>
References: <45144343.7080404@gmx.net>
Content-Type: text/plain
Date: Sat, 23 Sep 2006 16:13:22 +1000
Message-Id: <1158992002.14486.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-22 at 22:10 +0200, Carl-Daniel Hailfinger wrote:
> Hi Ben,
> 
> the patch below has been tested by Benjamin Okopnik and makes
> suspend-to-RAM work for him perfectly on his Acer Aspire 2010.
> Without this patch, a total lockup happens on resume.
> 
> I hope the patch is still in the merge window for 2.6.19.

Sure, I sent an Ack'ed-by in reply to another email about this patch. It
can go in anytime.

Ben.


