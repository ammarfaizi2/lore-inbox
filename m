Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWAILTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWAILTL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 06:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWAILTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 06:19:11 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:13521 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932228AbWAILTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 06:19:10 -0500
Date: Mon, 9 Jan 2006 12:19:06 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: balamurugan@sahasrasolutions.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: REG:problems
Message-ID: <20060109111906.GA22197@harddisk-recovery.com>
References: <63233.203.101.32.152.1136782788.squirrel@66.98.166.28>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63233.203.101.32.152.1136782788.squirrel@66.98.166.28>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 04:59:48AM -0000, balamurugan@sahasrasolutions.com wrote:
> i am cross compaling with arm-linux , i will face the following prombles
> ,u pls rectified it as soon as possible

"Please fix my problem in your free time" is not the correct attitude
for this mailing list.

> 1.Menuconfig has encountered a possible error in one of the kernel's
> configuration files and is unable to continue.  Here is the error
> report:
> 
>  Q> scripts/Menuconfig: line 832: MCmenu0: command not found
> 
> Please report this to the maintainer <mec@shout.net>.  You may also
> send a problem report to <linux-kernel@vger.kernel.org>.
> 
> Please indicate the kernel version you are trying to configure and
> which menu you were trying to enter when this error occurred.

The 2.4 kernel is no longer supported on ARM. To fix your problem,
upgrade to the latest 2.6 kernel.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
