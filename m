Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031157AbWI0WcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031157AbWI0WcW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031155AbWI0WcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:32:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51880 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031150AbWI0WcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:32:21 -0400
Date: Wed, 27 Sep 2006 15:32:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [BUG] Oops on boot (probably ACPI related)
Message-Id: <20060927153213.44fcfd1f.akpm@osdl.org>
In-Reply-To: <20060927205805.GA3262@athena.road.mcmartin.ca>
References: <200609271424.47824.eike-kernel@sf-tec.de>
	<pan.2006.09.27.17.56.13.80913@automagically.de>
	<20060927184037.GA3306@athena.road.mcmartin.ca>
	<p73fyedje0f.fsf@verdi.suse.de>
	<Pine.LNX.4.64.0609271320580.3952@g5.osdl.org>
	<20060927205805.GA3262@athena.road.mcmartin.ca>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 16:58:05 -0400
Kyle McMartin <kyle@parisc-linux.org> wrote:

> On Wed, Sep 27, 2006 at 01:21:17PM -0700, Linus Torvalds wrote:
> > On Wed, 27 Sep 2006, Andi Kleen wrote:
> > > I expect this patch to fix it.
> > 
> > Andrew, Kyle, can you verify?
> > 
> 
> Yup, it works.

Ditto.
