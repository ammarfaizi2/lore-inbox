Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268363AbRGXRBc>; Tue, 24 Jul 2001 13:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268289AbRGXRBW>; Tue, 24 Jul 2001 13:01:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27401 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268340AbRGXRBR>; Tue, 24 Jul 2001 13:01:17 -0400
Subject: Re: Arp problem
To: kubla@sciobyte.de (Dominik Kubla)
Date: Tue, 24 Jul 2001 17:34:33 +0100 (BST)
Cc: paul@clubi.ie (Paul Jakma), linux-kernel@vger.kernel.org
In-Reply-To: <20010724140916.F31198@intern.kubla.de> from "Dominik Kubla" at Jul 24, 2001 02:09:16 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15P58j-0000K2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> IMHO this is definitely a linux bug, since the kernel can not now about
> the true network topology: Cable sharing might just be used for this one
> system doing the routing/filtering/whatever between the two networks,
> while all the other hosts are in seperated switch segments. Not a common
> setup but you will see this often enough: head count is already 2... ;-)

The default Linux, Solaris setup is the standard. Take it up with the IETF
if you don't like it.
