Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbTANRY6>; Tue, 14 Jan 2003 12:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbTANRY6>; Tue, 14 Jan 2003 12:24:58 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:57793 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id <S264822AbTANRY5>; Tue, 14 Jan 2003 12:24:57 -0500
Date: Tue, 14 Jan 2003 18:33:48 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Which FB to use instead of vesafb?
Message-ID: <20030114173348.GG20592@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Which framebuffer works with a:

01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 420 Go] (rev a3) (prog-if 00 [VGA])
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 10
        Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Memory at ec000000 (32-bit, prefetchable) [size=64M]
        Memory at ebf80000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: <available only to root>
	
-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
Basic research is what I'm doing when I don't know what I'm doing.
                                              -- Wernher von Braun

