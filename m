Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129819AbRBRVMK>; Sun, 18 Feb 2001 16:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129850AbRBRVL7>; Sun, 18 Feb 2001 16:11:59 -0500
Received: from smarty.smart.net ([207.176.80.102]:7180 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S129819AbRBRVLt>;
	Sun, 18 Feb 2001 16:11:49 -0500
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200102182113.QAA32382@smarty.smart.net>
Subject: Re: Linux OS boilerplate
To: linux-kernel@vger.kernel.org
Date: Sun, 18 Feb 2001 16:13:34 -0500 (EST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you seen Janet_Reno? 

ftp://linux01.gwdg.de/pub/cLIeNUX/interim/Janet_Reno.tgz IIRC.
Janet is an x86 bootsector that gets into protected mode and can
use the AT BIOS in pmode interrupts. It's written with a bunch of
m4 macros I call asmacs that I'm currently basing an assembler in 
Bash on. That's shasm in the same directory as Janet.

Rick Hohensee
www.cLIeNUX.com
