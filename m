Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267844AbTCEQWF>; Wed, 5 Mar 2003 11:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267847AbTCEQWF>; Wed, 5 Mar 2003 11:22:05 -0500
Received: from nef.ens.fr ([129.199.96.32]:48649 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S267844AbTCEQWE>;
	Wed, 5 Mar 2003 11:22:04 -0500
Date: Wed, 5 Mar 2003 17:31:21 +0100 (MET)
From: David Monniaux <David.Monniaux@ens.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: David Monniaux <David.Monniaux@ens.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: C-Media 9739 codec - solution found
In-Reply-To: <1046438992.16598.14.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.03.10303051729300.7172-100000@basilic.ens.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Feb 2003, Alan Cox wrote:

> > This driver works well with 2.4.20.

Woops. I think I have said this too quickly. There seem to be some weird
behaviors with some applications (sounds like playing a 44.1 kHz buffer at
48 kHz, some cyclical "thud"). More too come when I have time to look at
the matter more closely.

