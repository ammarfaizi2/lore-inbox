Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbTETSZw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 14:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263866AbTETSZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 14:25:52 -0400
Received: from ossipee.unh.edu ([132.177.137.39]:30884 "EHLO ossipee.unh.edu")
	by vger.kernel.org with ESMTP id S263815AbTETSZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 14:25:51 -0400
Subject: pci1130 cardbus bridge is not assigned an IRQ
From: "Bradley W. Langhorst" <brad@langhorst.com>
Reply-To: brad@langhorst.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1053455930.20506.29.camel@unheq1>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 May 2003 14:38:50 -0400
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: http://pubpages.unh.edu/notes/mailfiltering.html
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-5.3, required 5,
	BAYES_20, USER_AGENT_XIMIAN)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using an older laptop and would like to get pcmcia working.
I see in the archives that someone else reported a similar problem about
a month ago but there were no replies.  I guess nobody knows whats
wrong...

I'm using 2.5.69 (but only after trying the 2.4 series).

Can anyone shed some light on this problem?

I'm able to spend some time on this - but I'm not very familiar with the
kernel internals so I'd appreciate some hand holding to get me started.

thanks!

brad



