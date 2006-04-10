Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWDJRvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWDJRvi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 13:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWDJRvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 13:51:38 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:37061 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751164AbWDJRvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 13:51:38 -0400
Subject: Re: [PATCH -rt] Buggy uart (for 2.6.16)
From: Steven Rostedt <rostedt@goodmis.org>
To: Gunther Mayer <gunther.mayer@gmx.net>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <443A8D70.3040906@gmx.net>
References: <1144676225.12145.30.camel@localhost.localdomain>
	 <443A8D70.3040906@gmx.net>
Content-Type: text/plain
Date: Mon, 10 Apr 2006 13:51:29 -0400
Message-Id: <1144691489.11958.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-10 at 18:53 +0200, Gunther Mayer wrote:

> >  
> >
> Can you name the exact 8250 model which is buggy ?
> 

It's a custom board and the serial is not attached to the PCI.  So you
will have to wait till tomorrow before I can get the specs. The ones
that have the specs are in Europe.

-- Steve

