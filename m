Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbUAYPdz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 10:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbUAYPdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 10:33:55 -0500
Received: from ihme.org ([212.226.113.138]:46236 "EHLO ihme.org")
	by vger.kernel.org with ESMTP id S264391AbUAYPdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 10:33:54 -0500
Date: Sun, 25 Jan 2004 17:33:52 +0200
To: linux-kernel@vger.kernel.org
Subject: More on i/o wait problems ->
Message-ID: <20040125153352.GA23360@ihme.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Jaakko Helminen <haukkari@ihme.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I switched back to 2.6.0 and it works like a charm, 10,8MBps over 100M LAN
with http. Something's definitely broken in 2.6.1.

-Jaakko Helminen
