Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbTEMSIi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbTEMSGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:06:42 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:33284 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261797AbTEMSFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:05:37 -0400
Subject: Re: 2.6 must-fix list, v2
From: James Bottomley <James.Bottomley@steeleye.com>
To: Mike Anderson <andmike@us.ibm.com>
Cc: akpm@digeo.com, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030513181106.GB1626@beaverton.ibm.com>
References: <1052845953.6663.23.camel@mulgrave> 
	<20030513181106.GB1626@beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 13 May 2003 13:18:00 -0500
Message-Id: <1052849882.6663.36.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-13 at 13:11, Mike Anderson wrote:
> qlogicisp (isp1020) - Convert to new eh and other issues. Could be
> covered by feral driver, but status unclear of inclusion of feral.
> Bug 140.

Missed, thanks

> iph5526.c - Compile failure. Bug 201.

missed, thanks.

> ini9100u.c - DMA-mapping conversion. Bug 213.

that is the initio driver, covered above

> tmscsim.c - Compile failure. Bug 219.

That is the dc390t driver, covered above.  I think the new dc395x driver
may finesse this problem, though.

> AM53C974.c - Compile failure Bug 220.

That's the am53c974, covered above (just couldn't be bothered to
capitalise).

James


