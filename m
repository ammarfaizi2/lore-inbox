Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263891AbTLJTrY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 14:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbTLJTrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 14:47:24 -0500
Received: from mail.scitechsoft.com ([63.195.13.67]:37057 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S263891AbTLJTrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 14:47:23 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Linus Torvalds <torvalds@osdl.org>
Date: Wed, 10 Dec 2003 11:48:45 -0800
MIME-Version: 1.0
Subject: RE: Linux GPL and binary module exception clause?
CC: "'Andre Hedrick'" <andre@linux-ide.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Message-ID: <3FD7081D.31093.61FCFA36@localhost>
References: <00af01c3bf41$2db12770$d43147ab@amer.cisco.com>
In-reply-to: <Pine.LNX.4.58.0312100923370.29676@home.osdl.org>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> In fact, a user program written in 1991 is actually still likely
> to run, if it doesn't do a lot of special things. So user programs
> really are a hell of a lot more insulated than kernel modules,
> which have been known to break weekly. 

IMHO (and IANAL of course), it seems a bit tenuous to me the argument 
that just because you deliberating break compatibility at the module 
level on a regular basis, that they are automatically derived works. 
Clearly the module interfaces could be stabilised and published, and if 
you consider the instance of a single kernel version in time, that module 
ABI *is* published and *is* stable *for that version*. Just because you 
make an active effort to change things and actively *not* document the 
ABI other than in the source code across kernel versions, doesn't 
automatically make a module a derived work. 

IMHO anyway.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

