Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264436AbRF1VVn>; Thu, 28 Jun 2001 17:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264446AbRF1VVd>; Thu, 28 Jun 2001 17:21:33 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11793 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264436AbRF1VVa>; Thu, 28 Jun 2001 17:21:30 -0400
Subject: Re: Announcing Journaled File System (JFS) release 1.0.0 available
To: slamaya@yahoo.com (Yaacov Akiba Slama)
Date: Thu, 28 Jun 2001 22:21:23 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B3B9DD2.1030103@yahoo.com> from "Yaacov Akiba Slama" at Jun 29, 2001 12:12:50 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FjE3-0007f9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> JFS doesn't require any modifications to existing code, its only an 
> addition.

It depends how clean the interface is. It is possible to avoid changing
core code by writing your own clone of it - that isnt good and doesnt make
people happy sometimes.

> XFS on the contrary is far more intrusive.

Right - XFS I think is 2.5 material - for cleanup time, for the core changes
it wants to provide. Maybe as a 2.4 backport later


