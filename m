Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTDGNza (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 09:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbTDGNza (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 09:55:30 -0400
Received: from linux.kappa.ro ([194.102.255.131]:20944 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id S263459AbTDGNz3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 09:55:29 -0400
Date: Mon, 7 Apr 2003 17:07:02 +0300
From: Teodor Iacob <Teodor.Iacob@astral.ro>
To: linux-kernel@vger.kernel.org
Subject: Bug Intel e100 driver 2.4.20-8 redhat 9
Message-ID: <20030407140702.GA18937@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When I load the e100 driver with the UTP cable plugged into the
adapter I get the following:

Intel(R) PRO/100 Network Driver - version 2.1.29-k2
Copyright (c) 2002 Intel Corporation

e100: selftest OK.
e100: hw init failed
e100: Failed to initialize, instance #0

if i remove the cable and load the driver and only then I plug the cable
it works fine.

The machine is an Intel SCB2 with e100 on-board.


-- 
      Teodor Iacob,
Network Administrator
Astral TELECOM Internet
