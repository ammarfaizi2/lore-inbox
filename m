Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbULGDTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbULGDTG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 22:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbULGDTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 22:19:06 -0500
Received: from mx01.cybersurf.com ([209.197.145.104]:51666 "EHLO
	mx01.cybersurf.com") by vger.kernel.org with ESMTP id S261747AbULGDTD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 22:19:03 -0500
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Karsten Desler <kdesler@soohrt.org>
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       "David S. Miller" <davem@davemloft.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041207025456.GA525@soohrt.org>
References: <20041206224107.GA8529@soohrt.org>
	 <E1CbSf8-00047p-00@calista.eckenfels.6bone.ka-ip.net>
	 <20041207002012.GB30674@quickstop.soohrt.org>
	 <1102387595.1088.48.camel@jzny.localdomain>
	 <20041207025456.GA525@soohrt.org>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1102389533.1089.51.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 06 Dec 2004 22:18:54 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-06 at 21:54, Karsten Desler wrote:


> The only thing I can think off is the 66/64 PCI bus and the
> disadvantageous placement of the PCI cards, but neither should cause a
> higher CPU usage. If the bus couldn't keep up, I'd get packetloss.
> 

cant tell offhand; it looks like a modern piece of hardware.
Are you sure you are using NAPI? This is an e1000, correct?

cheers,
jamal

