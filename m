Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268752AbUJFHQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268752AbUJFHQF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 03:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268771AbUJFHQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 03:16:04 -0400
Received: from relay-av.club-internet.fr ([194.158.96.107]:47094 "EHLO
	relay-av.club-internet.fr") by vger.kernel.org with ESMTP
	id S268752AbUJFHQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 03:16:03 -0400
Date: Wed, 6 Oct 2004 09:11:10 +0200
From: =?iso-8859-1?Q?S=E9bastien?= Hinderer 
	<Sebastien.Hinderer@libertysurf.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, rmk@arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] new serial flow control
Message-ID: <20041006071110.GA1112@galois>
References: <20041004225430.GF2593@bouh.is-a-geek.org> <20041004225530.GG2593@bouh.is-a-geek.org> <1097016674.23924.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1097016674.23924.12.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Here is patch for 2.6
> 
> How is this different from CRTSCTS ?

I'd say it is symmetric. I think the roles of RTS and CTS are exchanged.
Sam, am I right ?

Sébastien.
