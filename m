Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbTFHPyU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 11:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTFHPyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 11:54:20 -0400
Received: from mail.ithnet.com ([217.64.64.8]:36370 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S262090AbTFHPyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 11:54:20 -0400
Date: Sun, 8 Jun 2003 18:07:48 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: gibbs@scsiguy.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030608180748.03c06a04.skraw@ithnet.com>
In-Reply-To: <20030608134901.363ebe42.skraw@ithnet.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<20030605181423.GA17277@alpha.home.local>
	<20030608131901.7cadf9ea.skraw@ithnet.com>
	<20030608134901.363ebe42.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Justin,

another thing I stumbled across: if you compile the latest aic-driver
(20030603) for smp, but boot the kernel with nosmp flag, the driver hangs
during device-scan.

Regards,
Stephan
