Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270505AbTG1UQE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270824AbTG1UQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:16:04 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:30647 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S270505AbTG1UQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:16:02 -0400
Date: Mon, 28 Jul 2003 16:01:47 -0400
From: Ben Collins <bcollins@debian.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off automatic screen clanking
Message-ID: <20030728200147.GR17019@phunnypharm.org>
References: <Pine.LNX.4.53.0307281555400.27569@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307281555400.27569@chaos>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I need to know what the appropriate ioctl() is to do this
> directly without using escape sequences. I have searched
> the 2.4.20 sources and can't find any documentation for
> anything that remotely even looks like it turns off the
> automatic blanking. The code appears to be truly magic.

You could have just run "setterm -blank 0"

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
