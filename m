Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284171AbRLKXzP>; Tue, 11 Dec 2001 18:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284177AbRLKXzG>; Tue, 11 Dec 2001 18:55:06 -0500
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:48391
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S284171AbRLKXy7>; Tue, 11 Dec 2001 18:54:59 -0500
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200112112329.fBBNTqc13889@www.hockin.org>
Subject: Re: NULL pointer dereference in moxa driver
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 11 Dec 2001 15:29:51 -0800 (PST)
Cc: skraw@ithnet.com (Stephan von Krawczynski),
        xi@borderworlds.dk (Christian Laursen), linux-kernel@vger.kernel.org
In-Reply-To: <E16DwgD-0007R1-00@the-village.bc.nu> from "Alan Cox" at Dec 11, 2001 11:51:21 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is no maintainer, and our code base has drifted a fair way from what
> moxa originally submitted (being a 2.0 driver with the serial transmit race
> bug).
> 
> Anyone who wants to beat the mxser driver into shape, go for it.

I'm using it under 2.4.x, but I missed the rest of this thread - what are
the issues?

