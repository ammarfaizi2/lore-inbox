Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264190AbTICWlk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 18:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264239AbTICWlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 18:41:40 -0400
Received: from mail.webmaster.com ([216.152.64.131]:23766 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S264190AbTICWlc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 18:41:32 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Pascal Schmidt" <der.eremit@email.de>,
       "Andre Hedrick" <andre@linux-ide.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Driver Model
Date: Wed, 3 Sep 2003 15:41:03 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEMAGDAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <E19ucah-0000iH-00@neptune.local>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On Wed, 03 Sep 2003 20:00:24 +0200, you wrote in linux.kernel:

> > The fact that GPL_ONLY horse sh*t exists means there is a restriction on
> > usage.  So "GPL_ONLY" has in effect violated GPL, by imposing
> > restrictions
> > of usage.

> Where is the restriction? You get the source code, you can roll your
> own and remove the GPL_ONLY stuff. Apart from that I do not recall
> to have seen anything about restrictions of usage in the GPL... the
> only thing it tries to prevent is the source code becoming proprietary.

	If the GPL_ONLY stuff is a license enforcement scheme, the DMCA prohibits
you from removing it. If the GPL_ONLY stuff is not a license enforcement
scheme, nothing prohibits you from stamping your module GPL when it's not.

	However, the GPL (section 2b) prohibits you from imposing any restrictions
other than those in the GPL itself. The GPL contains no restrictions that
apply to mere use and the GPL_ONLY stuff affects use, so it can't be a
license restriction, hence there is no restriction to enforce.

	I don't see anything preventing a GPL'd work from containing code that
imposes restrictions actually contained in the GPL and using the DMCA to
enforce them. But it would have to be a restriction contained in the GPL
itself, and there is no restriction about what code you can use with a GPL'd
work.

	DS


