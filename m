Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287552AbSALVk4>; Sat, 12 Jan 2002 16:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287518AbSALVks>; Sat, 12 Jan 2002 16:40:48 -0500
Received: from node10450.a2000.nl ([24.132.4.80]:8576 "EHLO awacs.dhs.org")
	by vger.kernel.org with ESMTP id <S287552AbSALVkG>;
	Sat, 12 Jan 2002 16:40:06 -0500
Date: Sat, 12 Jan 2002 22:40:05 +0100
From: Pascal Haakmat <a.haakmat@chello.nl>
To: linux-kernel@vger.kernel.org
Subject: Andre Hedrick's IDE patch saved my life
Message-ID: <20020112224005.A19577@awacs.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, that's perhaps not entirely true, but they did solve the mysterious
and funny, and not so funny, problems that I was having with Oopses and
filesystem corruption (kernel 2.4.16, 2xPIII/600MHz, PIIX4, XFS).

Is there any reason at all why these patches are not part of the stock
kernel? I mean the kernel just lost a disk of mine: is there any reason
worth a disk of lost data?
