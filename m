Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbTLOMIe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 07:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTLOMIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 07:08:34 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17835 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263564AbTLOMId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 07:08:33 -0500
Date: Mon, 15 Dec 2003 13:08:31 +0100
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: ATI Rage 128 problem with 2.4.23 & 2.6.0-test11
Message-ID: <20031215120830.GB11418@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  I have a problem with acceleration on ATI Rage 128 on both 2.4.23 and
2.6.0-test11. If I run X with DRI enabled and some game using it then
shortly kernel starts printing message like:
 *ERROR* r128_freelist_get() returning NULL!

At that moment X freeze completely... Is there some solution for this
problem?

The machine is MSI KT4AVL board with Barton 2500+. agpgart is not
working in 2.4.23 but in 2.6.0-test11 it works perfectly (it runs in 1x
mode). If some more information or testing is needed please ask.

									Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
