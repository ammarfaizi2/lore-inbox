Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282465AbRKZUSb>; Mon, 26 Nov 2001 15:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282466AbRKZUSW>; Mon, 26 Nov 2001 15:18:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1286 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282465AbRKZUSH>; Mon, 26 Nov 2001 15:18:07 -0500
Subject: Re: Network card timeouts
To: anli@perceptive.se (Anders Linden)
Date: Mon, 26 Nov 2001 20:26:26 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <71C83C8929F73A40BBD0C137232DD1972ED4@piff.i.perceptive.se> from "Anders Linden" at Nov 21, 2001 07:16:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E168SKg-0006jd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The later card, Davicom, is probably not a well-known card, but
> nevertheless, it works like shit in Linux. I am using Redhat 7.1 and th=
> e
> kernel 2.4.2-2. If I send more than 10M to such a card in an interval o=

Davicom is a bad tulip clone. It has a (not very good) davicom provided
driver in 2.4.2 or you can use tulip or the updated davicom provided dfme
driver in newer 2.4
