Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUGZTeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUGZTeW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 15:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbUGZTeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 15:34:21 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:4259 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265920AbUGZSMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 14:12:12 -0400
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Autotune swappiness01 
In-reply-to: Your message of Mon, 26 Jul 2004 12:54:01 +0200.
             <200407261254.01186.rjwysocki@sisk.pl> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24031.1090864533.1@us.ibm.com>
Date: Mon, 26 Jul 2004 10:55:36 -0700
Message-Id: <E1Bp9hI-0006Fk-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2004 12:54:01 +0200, "R. J. Wysocki" wrote:
> On Monday 26 of July 2004 12:29, Con Kolivas wrote:
> > R. J. Wysocki wrote:
> > > Perhaps we need a bit more sophisticated swap algorithm than other OSes
> > > do. For example, couldn't we add an additional parameter to control the
> > > swapping "behavior", apart from the swappiness?  Something like adding
> > > the second knob in my radio example?  Just thinking,
> >
> > I think one knob is one knob too many already.
> 
> Can you please tell me why do you think so?

The more knobs there are, the higher the chances that most of them
are incorrectly set, no matter the workload.

gerrit
