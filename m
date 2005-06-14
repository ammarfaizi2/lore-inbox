Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVFNDik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVFNDik (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 23:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVFNDik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 23:38:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:59891 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S261406AbVFNDij
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 23:38:39 -0400
Date: Mon, 13 Jun 2005 20:38:03 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Valdis.Kletnieks@vt.edu
cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       bhuey@lnxw.com, nickpiggin@yahoo.com.au, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance 
In-Reply-To: <200506140329.j5E3TGYD014420@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.10.10506132034590.31659-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Jun 2005 Valdis.Kletnieks@vt.edu wrote:

> On Mon, 13 Jun 2005 17:48:56 PDT, Daniel Walker said:
> > On Fri, 2005-05-27 at 11:14 +0200, Ingo Molnar wrote:
> 
> > > to make sure the wide context has not been lost: no way is IRQ threading 
> > > ever going to be the main or even the preferred mode of operation.
> > 
> > That's depressing .. You not ever submitting IRQ threading upstream ?
> 
> My reading was "in the same sense that NUMA and cpusets aren't the main or
> preferred mode of operation".  But that's just my reading of it - Ingo may
> have meant something else...


I may have miss read it .. The question still stands, because interrupts
in threads is a key feature. Other major features depend on it . If he
doesn't have intentions to submit that up stream than a good percentage of
the rest of the patch isn't going up stream either.

Daniel 

