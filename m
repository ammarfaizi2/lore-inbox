Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292957AbSCRLVt>; Mon, 18 Mar 2002 06:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292971AbSCRLVj>; Mon, 18 Mar 2002 06:21:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56843 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292957AbSCRLV0>; Mon, 18 Mar 2002 06:21:26 -0500
Subject: Re: 2.4.19-pre3-ac1 - Quotactl patch
To: spstarr@sh0n.net (Shawn Starr)
Date: Mon, 18 Mar 2002 11:36:45 +0000 (GMT)
Cc: nathans@sgi.com (Nathan Scott), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0203180152260.21632-100000@coredump.sh0n.net> from "Shawn Starr" at Mar 18, 2002 01:53:06 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mvRV-0004pu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Right, but which old patch 2.4.18-pre3-quotactl reversed against
> 2.4.19-pre3-ac1 doesnt go out cleanly without patch complaining about
> unreversed patch problems.

It isnt a single patch, its patches with further fixes on top.
