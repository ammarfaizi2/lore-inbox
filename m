Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266386AbUFUS3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266386AbUFUS3n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 14:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266383AbUFUS3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 14:29:43 -0400
Received: from area2-51.knoware.nl ([213.169.196.51]:55589 "EHLO
	raq.textinfo.nl") by vger.kernel.org with ESMTP id S266386AbUFUS3U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 14:29:20 -0400
Date: Mon, 21 Jun 2004 20:29:12 +0200 (CEST)
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
X-X-Sender: <rbultje@raq.textinfo.nl>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Laurent Pinchart <laurent.pinchart@skynet.be>,
       Mailinglist <mjpeg-users@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Mjpeg-users] [2.6 patch] let VIDEO_ZORAN depend on I2C_ALGOBIT
In-Reply-To: <20040621153817.GD28607@fs.tum.de>
Message-ID: <Pine.LNX.4.33.0406212022010.23565-100000@raq.textinfo.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Mon, 21 Jun 2004, Adrian Bunk wrote:
> The following compile error occurs with VIDEO_ZORAN=y and I2C_ALGOBIT=n
> in 2.6.7-mm1 (but it's not specific to -mm):
[..]
> The following patch fixes this issue:
[..]

Thanks, I'll take care of sending this upstream. I think that you're
currently required to "sign off" a patch when you sent it over to
maintainers. See e.g. http://www.linuxdevices.com/news/NS3012318028.html
for details. It's really as simple as including a line
"Signed-off-by: Random J Developer <you@mail.com>" in your patch email.
See http://kerneltrap.org/node/view/3180 for details and Linus' initial
email.

Thanks,

Ronald

