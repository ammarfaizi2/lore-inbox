Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284165AbRLDBqC>; Mon, 3 Dec 2001 20:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282896AbRLDANN>; Mon, 3 Dec 2001 19:13:13 -0500
Received: from pD903C759.dip.t-dialin.net ([217.3.199.89]:31872 "EHLO
	no-maam.dyndns.org") by vger.kernel.org with ESMTP
	id <S285284AbRLCWhZ>; Mon, 3 Dec 2001 17:37:25 -0500
Date: Mon, 3 Dec 2001 23:36:12 +0100
To: linux-kernel@vger.kernel.org
Subject: Strange messages with 2.4.16
Message-ID: <20011203233612.J11967@no-maam.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
From: erik.tews@gmx.net (Erik Tews)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

After having bootet 2.4.16 vanilla on an dual piii-system, I saw the
following messages:

invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer

They appear during the execution of vgscan. The same kernel on an other
machine with the same version of userland-utilities for lvm but other
hardware doesn't show anyone of these messages. What do they want to
tell me? Has anybody else seen this messages?

I can give you an detailed report about the hardware I am seeing this
messages on if intrested.
