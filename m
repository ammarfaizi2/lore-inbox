Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264372AbUD0WR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbUD0WR1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 18:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbUD0WRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 18:17:22 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:56534 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S264372AbUD0WRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 18:17:17 -0400
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Apr 2004 23:17:16 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-ID: <408EE9FC.23550.3952D7BF@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sad state of affairs.

I don't know anything on the guru's side of coding and stuff in the 
kernel, but I do know enough to say the module in question WAS coded 
to give a false impression (or true, if you like) to the kernel so 
that it supressed the 'tainted' kernel warnings.

But surely in an open source project [any project], tainted code 
needs to be highlighted?  What else is in there, or not?  A GNU/Linux 
platform needs to be told when a unknown and unvetted binary loads  - 
who can prove what it does otherwise, and therefore the onus is on 
the user?

Maybe binary suppliers need to speak to kernel crew first on what 
they need to do to get around these issues legally before it is 
'discovered' and appears to be an attempt get around safeguards in 
place.

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."

