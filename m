Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265433AbTLHOQQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 09:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265430AbTLHOQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 09:16:16 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:16771
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S265427AbTLHOQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 09:16:11 -0500
Date: Mon, 8 Dec 2003 09:15:09 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Paul Rolland <rol@as2917.net>
cc: "'Paul Rolland'" <rol@witbe.net>, linux-smp@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: WARNING: MP table in the EBDA can be UNSAFE
In-Reply-To: <200312081023.hB8ANZD26556@tag.witbe.net>
Message-ID: <Pine.LNX.4.58.0312080913360.4000@montezuma.fsmlabs.com>
References: <200312081023.hB8ANZD26556@tag.witbe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003, Paul Rolland wrote:

> > Indeed it is, you need to turn on "Multi-node NUMA system support"
> >
> > CONFIG_X86_NUMA
>
> That was it !
>
> Great, the machine now sees all its CPUs.
>
> The BogoMips number is rather strange (200 for a Xeon 2.4 GHz), but
> the machine is really fine now....

I wonder if that's an artifact of the timesource, for my edification could
you send your new bootlogs?

Ta

