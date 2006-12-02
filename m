Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423165AbWLBLar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423165AbWLBLar (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423351AbWLBLar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:30:47 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38880 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1423165AbWLBLaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:30:46 -0500
Date: Sat, 2 Dec 2006 11:37:52 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Karsten Weiss <knweiss@gmx.de>
Cc: Christoph Anton Mitterer <calestyo@scientia.net>,
       linux-kernel@vger.kernel.org
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives //
 memory hole mapping related bug?!
Message-ID: <20061202113752.47dab7c6@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0612021048200.2981@addx.localnet>
References: <4570CF26.8070800@scientia.net>
	<Pine.LNX.4.64.0612021048200.2981@addx.localnet>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2006 12:00:36 +0100 (CET)
Karsten Weiss <knweiss@gmx.de> wrote:

> Hello Christoph!
> 
> On Sat, 2 Dec 2006, Christoph Anton Mitterer wrote:
> 
> > I found a severe bug mainly by fortune because it occurs very rarely.
> > My test looks like the following: I have about 30GB of testing data on
> 
> This sounds very familiar! One of the Linux compute clusters I
> administer at work is a 336 node system consisting of the
> following components:

See the thread http://lkml.org/lkml/2006/8/16/305

