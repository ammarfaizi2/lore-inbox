Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130503AbRCLQvV>; Mon, 12 Mar 2001 11:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130502AbRCLQvM>; Mon, 12 Mar 2001 11:51:12 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2067 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130471AbRCLQuz>; Mon, 12 Mar 2001 11:50:55 -0500
Subject: Re: Linux 2.4.2ac18
To: h.lubitz@internet-factory.de (Holger Lubitz)
Date: Mon, 12 Mar 2001 16:53:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AACFB8B.B8F6D93B@internet-factory.de> from "Holger Lubitz" at Mar 12, 2001 05:38:35 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14cVZB-0002DC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> noticed that the overclocked CPU detection code was dropped between ac16
> and ac17. Since the changelog did not mention it - was the feature
> dropped intentionally, and if so, why?

It doesnt work usefully. The bit we really needed (clock multiplier reading)
does work so its a case of one won lost one

