Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbTFCTWB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 15:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTFCTWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 15:22:01 -0400
Received: from user72.209.42.38.dsli.com ([209.42.38.72]:11548 "EHLO
	nolab.conman.org") by vger.kernel.org with ESMTP id S263633AbTFCTWA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 15:22:00 -0400
Date: Tue, 3 Jun 2003 15:35:27 -0400 (EDT)
From: Mark Grosberg <mark@nolab.conman.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux and IBM : "unauthorized" mini-PCI : TCPA updates
Message-ID: <Pine.BSO.4.44.0306031532490.954-100000@kwalitee.nolab.conman.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Firstly IBM seem to claim the device supports mini-PCI but their public
> details do not make it clear IBM only allow its use with certain
> components so its not true mini-PCI - thats advertising and sales of
> goods happy lawsuit time, and remarkably careless.

Maybe there is a less evil explanation for this?

This is hypothetical, but before people go off and do something rash,
perhaps IBM prevents the card from booting for a technical reason. Maybe
it works electrically but in late testing they found it caused thermal or
electrical problems.

A quick fix would be to put a "do-not-boot" clause in the BIOS so the user
doesn't cook their machine.

Just a perspective from a (former) hardware person.

L8r,
Mark G.


