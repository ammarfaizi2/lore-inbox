Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWJ3OHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWJ3OHV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 09:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWJ3OHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 09:07:20 -0500
Received: from mx10.go2.pl ([193.17.41.74]:51666 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1751392AbWJ3OHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 09:07:19 -0500
Date: Mon, 30 Oct 2006 15:12:48 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Ingo Molnar <mingo@elte.hu>, Jiri Kosina <jikos@jikos.cz>,
       Marcel Holtmann <marcel@holtmann.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] lockdep: spin_lock_irqsave_nested() -v2
Message-ID: <20061030141248.GA4107@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	Jiri Kosina <jikos@jikos.cz>, Marcel Holtmann <marcel@holtmann.org>,
	David Woodhouse <dwmw2@infradead.org>
References: <20061030131241.GA1657@ff.dom.local> <1162215648.24143.186.camel@taijtu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162215648.24143.186.camel@taijtu>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 02:40:48PM +0100, Peter Zijlstra wrote:
> *sigh*, I truly am cursed today :-(
> 
> how about this...
> ---

Beautiful!

Jarek P.
