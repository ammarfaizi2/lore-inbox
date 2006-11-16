Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424670AbWKPVor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424670AbWKPVor (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424671AbWKPVoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:44:46 -0500
Received: from homer.mvista.com ([63.81.120.158]:30017 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1424670AbWKPVop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:44:45 -0500
Subject: Re: 2.6.19-rc6-rt0, -rt YUM repository
From: Daniel Walker <dwalker@mvista.com>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <Pine.LNX.4.64.0611162212110.21141@frodo.shire>
References: <20061116153553.GA12583@elte.hu>
	 <1163694712.26026.1.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611162212110.21141@frodo.shire>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 13:44:29 -0800
Message-Id: <1163713469.26026.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-16 at 22:12 +0100, Esben Nielsen wrote:
> On Thu, 16 Nov 2006, Daniel Walker wrote:
> 
> > On Thu, 2006-11-16 at 16:35 +0100, Ingo Molnar wrote:
> >
> >> -rt0 is a rebase of -rt to 2.6.19-rc6, with lots of updates and fixes
> >> included. It includes the latest -hrt-dynticks tree and more.
> >
> >
> > Does the zero carry and meaning or did you just decide start using zero
> > instead of one?
> >
> > Daniel
> 
> 0 bugs?

I already know there's a few. Should we start a known regression list?

Daniel

