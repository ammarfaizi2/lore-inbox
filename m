Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbVISSGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbVISSGU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 14:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbVISSGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 14:06:20 -0400
Received: from [151.97.230.9] ([151.97.230.9]:3303 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932529AbVISSGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 14:06:20 -0400
Message-Id: <20050919180231.358170000@zion.home.lan>
Date: Mon, 19 Sep 2005 20:02:31 +0200
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
To: stable@kernel.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: [patch 0/1] uml cricitical fix for -stable
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sending up this patch to merge it in -stable, given the big memory leak it
fixes. Thanks for attention.
--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
