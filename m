Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265277AbUE0ViD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265277AbUE0ViD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 17:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbUE0ViD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 17:38:03 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:51681 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S265277AbUE0Vh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 17:37:58 -0400
Date: Thu, 27 May 2004 14:37:51 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Arjan van de Ven <arjanv@redhat.com>, Anton Blanchard <anton@samba.org>
Cc: Thomas Zehetbauer <thomasz@hostmaster.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_IRQBALANCE for AMD64?
Message-ID: <20040527213750.GB7772@taniwha.stupidest.org>
References: <1085629714.6583.12.camel@hostmaster.org> <40B578F1.3090704@pobox.com> <1085675774.6583.23.camel@hostmaster.org> <20040527170334.GE23262@krispykreme> <1085629714.6583.12.camel@hostmaster.org> <40B578F1.3090704@pobox.com> <1085675774.6583.23.camel@hostmaster.org> <1085676625.7179.7.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040527170334.GE23262@krispykreme> <1085676625.7179.7.camel@laptop.fenrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 06:50:25PM +0200, Arjan van de Ven wrote:

> irqbalanced has NOT been obsoleted by CONFIG_IRQBALANCE.

On Fri, May 28, 2004 at 03:03:34AM +1000, Anton Blanchard wrote:

> > Seems to work, just like the i386 irqbalanced before it has been
> > obsoleted by CONFIG_IRQBALANCE
>
> No, CONFIG_IRQBALANCE is an x86 specific hack.



Why do we have CONFIG_IRQBALANCE at all then?



  --cw
