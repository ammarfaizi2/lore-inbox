Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271274AbTGPXeO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 19:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271268AbTGPXdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 19:33:47 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.19.221]:30643 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S271258AbTGPXbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 19:31:37 -0400
Date: Thu, 17 Jul 2003 01:46:22 +0200
From: Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 sound drivers?
Message-ID: <20030717014622.B32081@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030716225826.GP2412@rdlg.net> <20030717011008.A32081@ss1000.ms.mff.cuni.cz> <20030716232933.GQ2412@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030716232933.GQ2412@rdlg.net>; from Robert.L.Harris@rdlg.net on Wed, Jul 16, 2003 at 07:29:33PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /dev/sound/dsp doesn't exist.

<1058182153.3913.6.camel@garaged.homeip.net> seems to solve your problem. You
can also find it at
http://www.ussg.iu.edu/hypermail/linux/kernel/0307.1/2023.html

In short, unset CONFIG_DEVFS_MOUNT.

Did it help?

Rudo.
