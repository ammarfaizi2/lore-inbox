Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754883AbWKPWhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883AbWKPWhc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 17:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755422AbWKPWhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 17:37:32 -0500
Received: from homer.mvista.com ([63.81.120.158]:12169 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1754893AbWKPWhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 17:37:31 -0500
Subject: Re: 2.6.19-rc6-rt0, -rt YUM repository
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Esben Nielsen <nielsen.esben@googlemail.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20061116220733.GA17217@elte.hu>
References: <20061116153553.GA12583@elte.hu>
	 <1163694712.26026.1.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611162212110.21141@frodo.shire>
	 <1163713469.26026.4.camel@localhost.localdomain>
	 <20061116220733.GA17217@elte.hu>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 14:37:18 -0800
Message-Id: <1163716638.26026.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-16 at 23:07 +0100, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > [...] Should we start a known regression list?
> 
> please resend the bugs that still trigger for you with 2.6.19-rt0.


Did you look at the BKL reacquire issue I sent? Just looking over the
code briefly, it looks like it's still there.

Daniel

