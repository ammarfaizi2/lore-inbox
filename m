Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbTEMVD3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbTEMVD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:03:28 -0400
Received: from 7.Red-80-37-235.pooles.rima-tde.net ([80.37.235.7]:4485 "EHLO
	pau.intranet.ct") by vger.kernel.org with ESMTP id S262014AbTEMVD1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:03:27 -0400
Date: Tue, 13 May 2003 23:15:58 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
cc: Russell King <rmk@arm.linux.org.uk>
Subject: Re: no console found booting 2.5.69
In-Reply-To: <20030513111209.C5900@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0305132313190.1905-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 May 2003, Russell King wrote:

> On Tue, May 13, 2003 at 11:49:47AM +0200, Pau Aliagas wrote:

> > On Tue, 13 May 2003, Russell King wrote:

> > > Last night, I posted an updated patch in the "PCMCIA 2.5.X sleeping from
> > > illegal context" thread.

Tha patch works, AFAICS. With this patch the system does not hang and 
boots with the card inserted. I still have no solution for the console 
problem: the system does not boot and says "no console found".

Any hints?
Pau

