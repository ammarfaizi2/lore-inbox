Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262664AbSK0OFq>; Wed, 27 Nov 2002 09:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262692AbSK0OFq>; Wed, 27 Nov 2002 09:05:46 -0500
Received: from grobbebol.xs4all.nl ([194.109.248.218]:13632 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262664AbSK0OFp>; Wed, 27 Nov 2002 09:05:45 -0500
Date: Wed, 27 Nov 2002 15:13:04 +0100
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: clock skew when writing cd (ide-scsi)
Message-ID: <20021127141304.GA21141@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I did check google on this but so far I didn't find a reason or fix yet.

using 2.4.18 (or previous), I always see on both my older BP6 as well as
the current system that there is a clock skew.

if I burn 6 or 7 cd's the total system time is approx one hour behind.

there are no messages in the logs that could hint me what the problem
is.

anyone an idea ?


