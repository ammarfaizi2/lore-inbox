Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbUFHKbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUFHKbP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 06:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264962AbUFHKbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 06:31:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:42184 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262080AbUFHKbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 06:31:14 -0400
Date: Tue, 8 Jun 2004 12:32:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mike McCormack <mike@codeweavers.com>
Cc: Jakub Jelinek <jakub@redhat.com>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040608103221.GA7632@elte.hu>
References: <40C2B51C.9030203@codeweavers.com> <20040606052615.GA14988@elte.hu> <40C2D5F4.4020803@codeweavers.com> <1086507140.2810.0.camel@laptop.fenrus.com> <20040608092055.GX4736@devserv.devel.redhat.com> <40C59FE9.1010700@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C59FE9.1010700@codeweavers.com>
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


* Mike McCormack <mike@codeweavers.com> wrote:

> I did not investigate this, but others who did think that it is not
> possible to create a segment that is reserve only so that does not
> unnecessarily consume virtual memory. Apparently ELF allows it, but
> Linux doesn't.

what do you mean by "Linux doesn't"?

	Ingo
