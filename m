Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbTKUXVr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 18:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbTKUXVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 18:21:47 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:30380 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261733AbTKUXVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 18:21:46 -0500
Date: Fri, 21 Nov 2003 15:46:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Cirrus Logic CS 4614/22/24 driver (IBM thinkpad T21)
Message-ID: <941270000.1069458415@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone got the driver for this thing to work for more than about
24 hours? Seems to descend slowly into crackly hell. Or are there any
ways to debug these damned things?

Multimedia audio controller: 
Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)

CONFIG_SND_CS46XX=y
CONFIG_SND_ENS1371=y

ALSA device list:
  #0: Sound Fusion CS46xx at 0xe8122000/0xe8000000, irq 11


