Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754634AbWKMNcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634AbWKMNcq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 08:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754635AbWKMNcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 08:32:46 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:49851 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1754634AbWKMNcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 08:32:45 -0500
Date: Mon, 13 Nov 2006 14:32:43 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Ivan Ukhov <uvsoft@gmail.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: /dev before the root filesystem is mounted
Message-ID: <20061113133242.GA4019@harddisk-recovery.com>
References: <a5de567c0611130252m52de5071vc25589bfd89b9c27@mail.gmail.com> <Pine.LNX.4.61.0611131234140.28210@yvahk01.tjqt.qr> <a5de567c0611130415t6cbe97efr8e60a3d3e091d04d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5de567c0611130415t6cbe97efr8e60a3d3e091d04d@mail.gmail.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 03:15:26PM +0300, Ivan Ukhov wrote:
> i dont use initrd. the kernel understands argument 'root=/dev/...', so
> /dev should exist, mb not in a real filesystem, but just in ram or
> something. i just want to know what devices are available for being
> the root filesystem for the kernel (displaying all available devices
> will be enough for me).

/dev does not exist because there is no root filesystem mounted. Please
read http://kernelnewbies.org/RootFileSystem .


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
