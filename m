Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbUASJuc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 04:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264480AbUASJuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 04:50:32 -0500
Received: from naboo.ethz.ch ([129.132.17.66]:31376 "EHLO mail.vis.ethz.ch")
	by vger.kernel.org with ESMTP id S264476AbUASJub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 04:50:31 -0500
Date: Mon, 19 Jan 2004 10:50:28 +0100
From: "Robert R. Simons" <robert@vis.ethz.ch>
To: linux-kernel@vger.kernel.org
Subject: SiS 648FX AGP problem
Message-ID: <20040119095028.GA28213@vis.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Whenever i try to enable DRI in X, my PC hangs on startup of the X
Server.
(If i do not load the agpgart and sis-agp modules, DRI is disabled).

I have a Gigabyte mainboard with a SiS 648FX Northbridge, and
and a Radeon 9200SE agp graphics board.
i use gentoo-dev-sources: kernel-2.6.1 with gentoo patches.

I have seen some patch mentioned on this list by Oliver Heilmann, but
couldn't find it anywhere. If he, or someone else who has this patch
could publish it, or send it to me, i would appreciate that.

cheers 
Robert Simons
