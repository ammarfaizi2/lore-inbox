Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbSKTUkm>; Wed, 20 Nov 2002 15:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbSKTUkm>; Wed, 20 Nov 2002 15:40:42 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:1412 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262360AbSKTUkl>; Wed, 20 Nov 2002 15:40:41 -0500
Subject: Re: spinlocks, the GPL, and binary-only modules
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andre Hedrick <andre@linux-ide.org>, Cort Dougan <cort@fsmlabs.com>,
       Xavier Bestel <xavier.bestel@free.fr>,
       Mark Mielke <mark@mark.mielke.cc>, Rik van Riel <riel@conectiva.com.br>,
       David McIlwraith <quack@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DDBF383.3020907@pobox.com>
References: <Pine.LNX.4.10.10211201152000.3892-100000@master.linux-ide.org>
	<1037825373.3241.69.camel@irongate.swansea.linux.org.uk> 
	<3DDBF383.3020907@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Nov 2002 21:15:34 +0000
Message-Id: <1037826934.3267.75.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 20:41, Jeff Garzik wrote:
> Have we decided that #include'ing GPL'd code does, or does not, taint 
> otherwise "license-clean" code that includes the GPL'd code?

Ask a lawyer - and the answer mostly is "it depends"

> we fall to copyright law, and wonder aloud if an obviously-non-derived 
> work #includes GPL'd code, does it become derived?

Example 1

	I paste your name and address into my document does it become
	a derived work

Example 2

	I paste your poem into my document does it become a derived work


So #include isnt terribly relevant 8)

