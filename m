Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263882AbRFITcd>; Sat, 9 Jun 2001 15:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264481AbRFITcN>; Sat, 9 Jun 2001 15:32:13 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:29015 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263882AbRFITcE>; Sat, 9 Jun 2001 15:32:04 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200106091931.f59JVw731673@devserv.devel.redhat.com>
Subject: Re: [patch] ess maestro, support for hardware volume control
To: lukas@edeal.de (Lukas Schroeder)
Date: Sat, 9 Jun 2001 15:31:58 -0400 (EDT)
Cc: alan@redhat.com, zab@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010609190917.A10629@kosmo.edeal.de> from "Lukas Schroeder" at Jun 09, 2001 07:09:17 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this patch applies to (at least) 2.4.3 up to and including 2.4.6-pre2.
> It enables the hardware volume control feature of the maestro.

it doesnt apply to the current version of the maestro driver (2.4.5-ac) 
however. I think it is clashing with the docking station support
