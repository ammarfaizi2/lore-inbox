Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263302AbTJVMkr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 08:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTJVMkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 08:40:47 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:688 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263302AbTJVMkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 08:40:46 -0400
Subject: Re: cset #'s stable?
From: David Woodhouse <dwmw2@infradead.org>
To: Chris Wright <chrisw@osdl.org>
Cc: Frank Cusack <fcusack@fcusack.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20031021095209.A32703@osdlab.pdx.osdl.net>
References: <20031021091347.A7526@google.com>
	 <20031021095209.A32703@osdlab.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1066826441.29915.359.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Wed, 22 Oct 2003 13:40:43 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-21 at 09:52 -0700, Chris Wright wrote:
> * Frank Cusack (fcusack@fcusack.com) wrote:
> > Are changeset #'s stable?
> > 
> > I'm specifically looking at linux-2.5/net/sunrpc/clnt.c,
> > "rev 1.1153.63.[123]" which I recorded earlier as 1.1153.48.[123].
> 
> No, they are not.  The key, however, is stable (bk changes -k -r<rev>,
> for example).

This is in the X-BK-ChangeSetKey: header of the mails sent to the
mailing lists.

-- 
dwmw2

