Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130253AbRDJR3J>; Tue, 10 Apr 2001 13:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbRDJR2t>; Tue, 10 Apr 2001 13:28:49 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61958 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130038AbRDJR2j>; Tue, 10 Apr 2001 13:28:39 -0400
Subject: Re: No 100 HZ timer !
To: lk@tantalophile.demon.co.uk (Jamie Lokier)
Date: Tue, 10 Apr 2001 18:27:35 +0100 (BST)
Cc: mikulas@artax.karlin.mff.cuni.cz (Mikulas Patocka),
        ds@schleef.org (David Schleef), alan@lxorguk.ukuu.org.uk (Alan Cox),
        mbs@mc.com (Mark Salisbury), jdike@karaya.com (Jeff Dike),
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010410191528.B21024@pcep-jamie.cern.ch> from "Jamie Lokier" at Apr 10, 2001 07:15:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14n1vV-0004gX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Games would like to be able to page flip at vertical refresh time --
> <1ms accuracy please.  Network traffic shaping benefits from better than

This is an X issue. I was talking with Jim Gettys about what is needed to
get the relevant existing X extensions for this working

