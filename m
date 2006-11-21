Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966521AbWKUHIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966521AbWKUHIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 02:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934223AbWKUHIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 02:08:46 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:61334 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S934195AbWKUHIq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 02:08:46 -0500
Message-ID: <4562A605.8020606@drzeus.cx>
Date: Tue, 21 Nov 2006 08:08:53 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Anyone using MMC multi-slot?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I've been trying to come up with ways to clean up the MMC layer a bit,
and one idea I had was to remove the support for the bus topology. Both
SD and MMC4 have deprecated this design, so I'm suspecting it's not
something that is very popular.

So my question to you is, have you seen any hardware that uses the bus
feature of MMC and do you know if anyone runs Linux on it?

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
