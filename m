Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263685AbUE0M4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbUE0M4N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 08:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264102AbUE0M4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 08:56:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:64657 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263685AbUE0M4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 08:56:12 -0400
Date: Thu, 27 May 2004 14:45:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
Message-ID: <20040527124551.GA12194@elte.hu>
References: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com> <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu> <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526125300.GA18028@devserv.devel.redhat.com> <20040526130047.GF12142@wohnheim.fh-wedel.de> <20040526130500.GB18028@devserv.devel.redhat.com> <20040526164129.GA31758@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040526164129.GA31758@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:

> Anyway, whether we go for 4k in 2.6 or not, [...]

4K stacks have been added to the 2.6 kernel more than a month ago, are
in the official 2.6.6 kernel and are used by FC2 happily, so objections
are a bit belated. I only reacted to Andrea's mail to clear up apparent
misunderstandings about the impact and implementation of this feature.

	Ingo
