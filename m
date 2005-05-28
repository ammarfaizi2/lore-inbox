Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262685AbVE1Ksc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbVE1Ksc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 06:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbVE1Ksc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 06:48:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47752 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262685AbVE1Ks0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 06:48:26 -0400
Date: Sat, 28 May 2005 11:48:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bill Huey <bhuey@lnxw.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050528104818.GA20488@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bill Huey <bhuey@lnxw.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
	Andi Kleen <ak@muc.de>,
	Sven-Thorsten Dietrich <sdietrich@mvista.com>,
	Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com> <20050528065500.GA17005@infradead.org> <20050528102259.GA3072@nietzsche.lynx.com> <20050528103417.GA3390@nietzsche.lynx.com> <20050528105003.GA3491@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050528105003.GA3491@nietzsche.lynx.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2005 at 03:50:03AM -0700, Bill Huey wrote:
> Also, to continue this open minded discussion and reply of yours. How do
> you think IO is submitted to a system like that so that those guarantees
> are met ? Obivously some kind deterministic mechanism is pushing those
> requests to the wire.

Unfortunately my employment contract doesn't allow me to tell you the
details of GRIO.

