Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267399AbUHJCID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267399AbUHJCID (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 22:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267400AbUHJCID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 22:08:03 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:39375 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267399AbUHJCH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 22:07:59 -0400
Subject: Re: [0/3] via-rhine: experimental patches
From: Lee Revell <rlrevell@joe-job.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040808140216.GA8181@k3.hellgate.ch>
References: <20040808140216.GA8181@k3.hellgate.ch>
Content-Type: text/plain
Message-Id: <1092103694.761.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 09 Aug 2004 22:08:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-08 at 10:02, Roger Luethi wrote:
> The following batch needs testing. I don't expect any notable
> regressions, but I could do with some reports on WOL (already in -mm)
> and suspend/resume.
> 

Maybe this is a known issue by now, but the via-rhine bug is still not
fixed in 2.6.8-rc3.  I had to replace it with the via-rhine.c from -mm2
to get online.

Lee

