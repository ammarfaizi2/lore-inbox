Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751582AbWA0WtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbWA0WtU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWA0WtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:49:20 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:464 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1751580AbWA0WtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:49:20 -0500
Date: Sat, 28 Jan 2006 00:49:19 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/11] sh cleanups
Message-ID: <20060127224919.GA30816@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a relatively small patch set for cleaning up some of the sh
code. There's also a board update for some of the recent changes
in here, so the defconfig update for that ends up taking a bit of
space..

Let me know if there's something you want dropped, otherwise please
consider for -mm. Against current git.
