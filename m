Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131942AbRDCOcr>; Tue, 3 Apr 2001 10:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131979AbRDCOch>; Tue, 3 Apr 2001 10:32:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16390 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131942AbRDCOcd>; Tue, 3 Apr 2001 10:32:33 -0400
Subject: Re: /proc/config idea
To: jerj@coplanar.net (Jeremy Jackson)
Date: Tue, 3 Apr 2001 15:32:57 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dlang@diginsite.com (David Lang),
        jgarzik@mandrakesoft.com (Jeff Garzik), ian@cs.umbc.edu (Ian Soboroff),
        linux-kernel@vger.kernel.org
In-Reply-To: <3AC9C577.920036CD@coplanar.net> from "Jeremy Jackson" at Apr 03, 2001 08:43:36 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kRrg-0008BQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> method) have these dependencies checked by insmod?  It would be simply
> smashing to have it all inherently bullet proof. (i know never say never, but
> lower maintenance then or simpler for users or something)

The goal of modversions is to do this. It isnt perfect. Keith Owens was talking
about several ideas to improve it at the 2.5 kickoff conference

