Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129281AbRCBQTb>; Fri, 2 Mar 2001 11:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129291AbRCBQTV>; Fri, 2 Mar 2001 11:19:21 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13318 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129281AbRCBQTN>; Fri, 2 Mar 2001 11:19:13 -0500
Subject: Re: Linux 2.4.2ac7
To: tigran@veritas.com (Tigran Aivazian)
Date: Fri, 2 Mar 2001 16:22:21 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0103021356370.6279-100000@penguin.homenet> from "Tigran Aivazian" at Mar 02, 2001 02:02:17 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14YsJz-0001rL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ah, I see, so we are using the Reserved (14 upwards) bits of the
> MSR_EBC_HARD_POWERON? Ok, so the task is to understand how the bus info is
> encoded.

Well actually they are documented in part by some of the intel and other
docs. But all the docs agree on the bus speed encoding ...



