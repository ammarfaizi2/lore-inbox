Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbTAOAa0>; Tue, 14 Jan 2003 19:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265532AbTAOAa0>; Tue, 14 Jan 2003 19:30:26 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:5393 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265523AbTAOAaZ>; Tue, 14 Jan 2003 19:30:25 -0500
Date: Wed, 15 Jan 2003 00:39:13 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Ducrot Bruno <poup@poupinou.org>
cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Which FB to use instead of vesafb?
In-Reply-To: <20030114201328.GB12522@poup.poupinou.org>
Message-ID: <Pine.LNX.4.44.0301150038170.23774-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Try rivafb, but I hear it is broken in 2.5 :)
> 
> Sound like to be broken..

I have new patches at http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz.

> There were patch around for 2.4.  Search for Paul Richards on lkml, or
> apply this one (Richards version diffed against 2.4.21-pre3).

The above patch is basiclly his ported to the new api.

