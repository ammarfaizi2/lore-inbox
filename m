Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266897AbSKKTq4>; Mon, 11 Nov 2002 14:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266902AbSKKTq4>; Mon, 11 Nov 2002 14:46:56 -0500
Received: from bohnice.netroute.lam.cz ([212.71.169.62]:59643 "HELO
	beton.cybernet.cz") by vger.kernel.org with SMTP id <S266897AbSKKTq4>;
	Mon, 11 Nov 2002 14:46:56 -0500
Date: Mon, 11 Nov 2002 21:42:48 +0100
From: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Sound: DMA (output) timed out - IRQ/DRQ config error?
Message-ID: <20021111214248.A24021@beton.cybernet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get Sound: DMA (output) timed out - IRQ/DRQ config error?
On a PPro 200MHz (DELL OptiPlex Pro) with builting Soudblaster (OSS)
and massive access to SCSI disk AHA 1524 (tar xzvf of a big archive)

  7:     686036          XT-PIC  soundblaster
 10:     614871          XT-PIC  aha152x

I would be worth the effort to block interrupts within the drivers
only on an absolutely necessary way. Or is it already happening?
   
-- 
Karel 'Clock' Kulhavy
