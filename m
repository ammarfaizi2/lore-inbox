Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316695AbSHOKvB>; Thu, 15 Aug 2002 06:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316705AbSHOKvB>; Thu, 15 Aug 2002 06:51:01 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:44870 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316695AbSHOKvB>; Thu, 15 Aug 2002 06:51:01 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200208151052.g7FAqID27695@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.20-pre2-ac1
To: kai@tp1.ruhr-uni-bochum.de (Kai Germaschewski)
Date: Thu, 15 Aug 2002 06:52:18 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), eyal@eyal.emu.id.au (Eyal Lebedinsky),
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208142120000.849-100000@chaos.physics.uiowa.edu> from "Kai Germaschewski" at Aug 14, 2002 09:30:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There surely has to be a way to get that working on all compilers? I seem
> to remember that adding a space after __FUNCTION__ was necessary in some
> cases (before the ','). Alas I don't have anything newer than 2.96 for 
> testing here.

I'll try just that in -ac2
