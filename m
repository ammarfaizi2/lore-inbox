Return-Path: <linux-kernel-owner+w=401wt.eu-S1750879AbXACPew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbXACPew (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 10:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbXACPew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 10:34:52 -0500
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:3789 "EHLO
	smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbXACPev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 10:34:51 -0500
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 10:34:51 EST
Message-ID: <459BCAD5.2020604@xs4all.nl>
Date: Wed, 03 Jan 2007 16:25:09 +0100
From: Udo van den Heuvel <udovdh@xs4all.nl>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: "kernel + gcc 4.1 = several problems" / "Oops in 2.6.19.1"
X-Enigmail-Version: 0.94.1.2
OpenPGP: id=8300CC02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just read about the subjects.
I have a firewall which has some issues.
First it was a VIA CL6000 (c3).
Now it is a EK8000 (c3-2) with different power supply, RAM and board of
course. Still I see strange things sometimes. Crashes, hangs, etc. Now
and then. Not too often.

I have in .config:
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_MVIAC3_2=y

Does this mean the issue applies to my own kernels?

Udo
