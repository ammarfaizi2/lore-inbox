Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbUDNPL7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 11:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264254AbUDNPL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 11:11:58 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:58579 "EHLO
	openlab.rtlab.org") by vger.kernel.org with ESMTP id S264258AbUDNPLu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 11:11:50 -0400
Date: Wed, 14 Apr 2004 11:11:47 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Shielded CPUs
In-Reply-To: <1081953482.11976.0.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.33L2.0404141111290.20579-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004, Arjan van de Ven wrote:

> On Wed, 2004-04-14 at 16:23, Calin A. Culianu wrote:
> > This might be a bit off-topic (and might belong in the rtlinux mailing
> > list), but I wanted people's opinion on LKML...
> >
> > There's an article in the May 2004 Linux Journal about some CPU affinity
> > features in Redhawk Linux that allow a process and a set of interrupts to
> > be locked to a particular CPU for the purposes of improving real-time
> > performance.
>
> well you can do both of those already in 2.6 and in all recent vendor
> 2.4's that I know of..... no patches needed.


Cool.. it's still not, strictly speaking, _hard_ realtime, though, is it?
Simply really good soft-realtime, right?


