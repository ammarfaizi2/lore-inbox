Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbUBYVOe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbUBYVN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:13:28 -0500
Received: from uranus.md1.de ([217.160.177.133]:17810 "EHLO uranus.md1.de")
	by vger.kernel.org with ESMTP id S261554AbUBYVMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:12:08 -0500
Date: Wed, 25 Feb 2004 22:11:41 +0100
To: Michael Hunold <hunold@convergence.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] new driver for teletext decoder SAA5246A
Message-ID: <20040225211141.GA16597@t-online.de>
References: <20040225113437.GA1824@t-online.de> <403CFBD9.2000607@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403CFBD9.2000607@convergence.de>
User-Agent: Mutt/1.3.28i
From: linux@MichaelGeng.de (Michael Geng)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Auf dem sogenannten "Multimedia eXtension Board", einer analogen
> TV-Karte auf saa7146 Basis, sitzt ein saa5281 Teletext-Prozessor.

Ich habe mir das Board gerade mal angesehen. Ausserdem habe ich das
Datenblatt fuer den SAA5281 mal ueberflogen. Der SAA5281 ist demnach
Software- und Hardwarekompatibel zum SAA5246.

> Vor langer Zeit (> 2 Jahren) habe ich mal den saa5249 Treiber gehackt,
> damit er auch mit dem saa5281 kooperiert. Hat auch gut geklappt,
> allerdings habe ich es vermieden, den Treiber mit in den 2.6er Kernel
> zu
> bringen, weil er einfach zu h?sslich war.

Kann ich mir den Treiber mal ansehen?

> Des weiteren hatte ich es dann irgenwann nicht mehr geschafft, die
> Teletext-Applikationen zu ?bersetzen und irgendwie war mir das ganze
> API
> dann zu bloated, so dass ich das Interesse verloren habe.

Ich auf meiner neuesten Linux-Installation von Martin Buck's Packet
eigentlich auch nur noch das blanke vtxget uebersetzen. Make vtxget
tut's immer noch. Momentan reicht mir das.

> Die Karten sind mittlerweile richtig, richtig billig auf EBay zu haben
> (oftmals f?r unter 10 EUR) und ich habe schon nen ganzen Stapel davon.
> 8-)
 
Was machst Du denn mit so vielen Karten?

Ich werde auch mal bei Ebay reinsehen, vielleicht kauf' ich mir auch
eine.

> Ich werde mir bei Gelegenheit deinen Treiber mal anschauen und
> gucken,
> was man da f?r den saa5281 Support reinbauen muss.

Wenn Du mir Deinen saa5281 Treiber schickst dann sehe ich mir evtl. das
gleiche mal in umgekehrter Richtung an.

Es tut gut zu hoeren, dass ich nicht der einzige bin, der die alten
SAA52xx noch verwenden will!
  
Tschuess,
Michael
  
