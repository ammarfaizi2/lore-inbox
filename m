Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbUARUMO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 15:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUARUMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 15:12:14 -0500
Received: from main.gmane.org ([80.91.224.249]:19378 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261953AbUARUMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 15:12:13 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jens Benecke <jens-usenet@spamfreemail.de>
Subject: Re: 2.6.1mm2: nforce2 IDE lockups + debug messages about mm/slab.c:1868
Date: Sun, 18 Jan 2004 21:12:18 +0100
Message-ID: <3470087.tyEklBsDEN@spamfreemail.de>
References: <7361760.2YrQ8yO7uQ@spamfreemail.de> <20040118014021.641dfbfe.backblue@netcabo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.6
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

backblue wrote:

> Before asking, please checkout the mailing list! I think that topic, it's
> releated to the one, i have talked, search for a7n8x-x in the lkml, and
> see.

I did, and it said in the thread that upgrading the BIOS semmed to help
sometimes, but is a workaround, not a fix. Compiling IDE drivers as modules
does not work currently (2.6.1mm2), and is therefore a bug (IMHO).


-- 
Jens Benecke
