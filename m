Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTFIRz4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 13:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbTFIRz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 13:55:56 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:37763 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261328AbTFIRzz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 13:55:55 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 9 Jun 2003 11:07:32 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Coding standards.  (Was: Re: [PATCH] [2.5] Non-blocking write
 can block)
In-Reply-To: <Pine.LNX.4.53.0306091346150.226@chaos>
Message-ID: <Pine.LNX.4.55.0306091101260.3614@bigblue.dev.mcafeelabs.com>
References: <Pine.HPX.4.33L.0306040144400.8930-100000@punch.eng.cam.ac.uk>
 <20030604065336.A7755@infradead.org> <3EDE0E85.7090601@techsource.com>
 <20030607001202.GB14475@kroah.com> <3EE4B4C3.80902@techsource.com>
 <20030609163959.GA13811@wohnheim.fh-wedel.de>
 <Pine.LNX.4.55.0306091001270.3614@bigblue.dev.mcafeelabs.com>
 <3EE4C4CD.1050809@inet.com> <Pine.LNX.4.53.0306091346150.226@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yOn Mon, 9 Jun 2003, Richard B. Johnson wrote:

> Last I looked, we had a good example in the Buslogic SCSI driver.
> However, just in case it's been changed, I submit herewith an
> example of real code written by a "professional".

You know why the code you reported is *wrong* (besides from how
techincally do things) ? Mixing lower and upper case, using long variable
and function names, etc... are simply a matter of personal taste and you
cannot say that such code is "absolutely" wrong. The code is damn wrong
because it violates about 25 sections of the project's defined CodingStyle
document, that's why it is wrong.



- Davide

