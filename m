Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264559AbUAATir (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 14:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264563AbUAATir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 14:38:47 -0500
Received: from smtp.terra.es ([213.4.129.129]:63328 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S264559AbUAATip convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 14:38:45 -0500
Date: Thu, 1 Jan 2004 20:37:46 +0100
From: Diego Calleja <grundig@teleline.es>
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
Cc: manmower@signalmarketing.com, linux-kernel@vger.kernel.org
Subject: Re: best AMD motherboard for Linux
Message-Id: <20040101203746.2b6c7f5d.grundig@teleline.es>
In-Reply-To: <3FF45307.7070508@inet6.fr>
References: <3FEF0AFD.4040109@yahoo.com>
	<20031228172008.GA9089@c0re.hysteria.sk>
	<3FEF0AFD.4040109@yahoo.com>
	<20031228174828.GF3386@DervishD>
	<20031229165620.GF30794@louise.pinerecords.com>
	<Pine.LNX.4.58.0312301144340.467@uberdeity>
	<20031230194203.GA8062@louise.pinerecords.com>
	<Pine.LNX.4.58.0312301354130.765@uberdeity>
	<20031231093929.GC8062@louise.pinerecords.com>
	<Pine.LNX.4.58.0312310914170.473@uberdeity>
	<3FF45307.7070508@inet6.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 01 Jan 2004 18:04:07 +0100 Lionel Bouton <Lionel.Bouton@inet6.fr> escribió:

> Linux isn't a closed-source system where binary APIs are frozen, so 
> working best with a set of specific kernels (and I don't even say kernel 
> versions, I *mean* kernels, just search for threads on nvidia with 
> kernels built with some perfectly legit gcc flags) doesn't mean it is 
> working best with Linux.
> What if Nvidia goes bankrupt in the future like 3DFX did, what do you do 
> with your card ? throw it away ?


Yeah! I own a voodoo 3 3000 card. I've 100% opensource drivers. Under
windows XP, I suffer from hangs while playing some games. And looking
at the memory dump, the reponsible is the graphics driver, which
isn't updated just because tdfx has dissapeared, hence my voodoo card
is condemned to hang my box forever under windows.
And if anyone had a tdfx card in a powerpc machine, they could use it.
Unlike the propietary drivers: you have to use the framebuffer in your
ibook (with linux) because you don't have drivers for PPC. However,
Mac OS X has them....
